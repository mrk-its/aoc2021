use volatile_register::{RO, RW};

const DMACTL: usize = 0x22f;
const DLPTRS: usize = 0x230;
const TIMER: usize = 18;

#[derive(Clone, Copy, Default)]
struct DisplayListLine {
    pub mode: u8,
    pub addr: usize,
}

#[repr(C, align(512))]
struct DisplayList {
    pub header: [u8; 3],
    pub lines: [DisplayListLine; 137], // todo, do not hardcode!
    pub sep: [u8; 1],
    pub info: DisplayListLine,
    pub jmp: DisplayListLine,
}

impl DisplayList {
    pub fn update(&mut self, memory_addr: usize, info_addr: usize) {
        let mut addr = memory_addr;
        for line in self.lines.iter_mut() {
            line.mode = 0x4e;
            line.addr = addr;
            addr += 35;
        }
        self.info.addr = info_addr;
        self.jmp.addr = self as *mut DisplayList as usize;
        io_write(DLPTRS, self.jmp.addr);
        io_write(DMACTL, 0x21u8);
    }
}

impl Default for DisplayList {
    fn default() -> Self {
        Self {
            header: [0x70, 0x70, 0x70],
            lines: [Default::default(); 137],
            info: DisplayListLine {
                mode: 0x42,
                addr: 0,
            },
            sep: [0x70],
            jmp: DisplayListLine {
                mode: 0x41,
                addr: 0,
            },
        }
    }
}

pub fn io_write<T: Copy>(addr: usize, value: T) {
    unsafe {
        (*(addr as *const RW<T>)).write(value);
    }
}

pub fn io_read<T: Copy>(addr: usize) -> T {
    unsafe { (*(addr as *const RO<T>)).read() }
}

pub fn clock() -> u32 {
    io_read::<u8>(TIMER + 2) as u32
        + io_read::<u8>(TIMER + 1) as u32 * 256
        + io_read::<u8>(TIMER + 0) as u32 * 65536
}

#[derive(Default)]
pub struct Display {
    info: [u8; 32],
    dlist: DisplayList,
    start_t: u32,
}

impl Display {
    pub fn show(&mut self, board: &crate::Board, frame_cnt: usize, phase: u8) {
        self.dlist.update(
            board as *const crate::Board as usize,
            &self.info as *const [u8; 32] as usize,
        );
        let t = clock();
        if self.start_t == 0 {
            self.start_t = t;
        }
        let ticks = t - self.start_t;
        if phase == crate::SOUTH {
            io::slice_write_int(frame_cnt, &mut self.info[0..5]);
            io::slice_write_int(ticks, &mut self.info[16..26]);
        }
    }
}
