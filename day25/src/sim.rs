use io;

#[derive(Default)]
pub struct Display {}

impl Display {
    pub fn show(&mut self, board: &crate::Board, frame_cnt: usize, phase: u8) {
        if phase == crate::SOUTH {
            io::write_int(frame_cnt);
            io::writeln();
        }
    }
}
