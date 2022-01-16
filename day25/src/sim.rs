use ufmt_stdio::*;

#[derive(Default)]
pub struct Display {}

impl Display {
    pub fn show(&mut self, _board: &crate::Board, frame_cnt: usize, phase: u8) {
        if phase == crate::SOUTH {
            println!("{}", frame_cnt);
        }
    }
}
