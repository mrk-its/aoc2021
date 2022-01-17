use a800xl_utils::{
    clock, consts,
    screen::{clear_atract, ScreenMemoryWriter},
};

#[derive(Clone, Copy, Default)]
struct DisplayListLine {
    pub mode: u8,
    pub addr: u16,
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
    pub fn update(&mut self, memory_addr: u16, info_addr: u16) {
        let mut addr = memory_addr;
        for line in self.lines.iter_mut() {
            line.mode = 0x4e;
            line.addr = addr;
            addr += 35;
        }
        self.info.addr = info_addr;
        self.jmp.addr = self as *mut DisplayList as u16;

        unsafe {
            *consts::SDLST = self.jmp.addr;
            *consts::SDMCTL = 0x21;
        }
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

#[derive(Default)]
pub struct Display {
    info: [u8; 32],
    dlist: DisplayList,
    start_t: u32,
}

impl Display {
    pub fn show(&mut self, board: &crate::Board, frame_cnt: usize, phase: u8) {
        self.dlist.update(
            board as *const crate::Board as u16,
            &self.info as *const [u8; 32] as u16,
        );
        let t = clock();
        if self.start_t == 0 {
            self.start_t = t;
        }
        let ticks = t - self.start_t;
        if phase == crate::SOUTH {
            let mut writer = ScreenMemoryWriter::new(&mut self.info);
            ufmt::uwrite!(&mut writer, "#{}    frames: {}", frame_cnt, ticks).unwrap();
            clear_atract();
        }
    }
}
