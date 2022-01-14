#![no_std]
#![feature(start)]
io::entry!(main);

include!(concat!(env!("OUT_DIR"), "/input.rs"));

#[cfg(target_vendor = "a800xl")]
#[path = "atari.rs"]
mod ui;

#[cfg(not(target_vendor = "a800xl"))]
#[path = "sim.rs"]
mod ui;

pub const EAST: u8 = 1;
pub const SOUTH: u8 = 2;

fn get_c(board: &Board, offs: usize, pos: u8) -> u8 {
    let pos = 3 - pos;
    let n = (pos & 3) << 1;
    (board[offs] >> n) & 3
}

const MASKS: [u8; 4] = [!(3 << 6), !(3 << 4), !(3 << 2), !(3 << 0)];
const SHIFTS1: [u8; 4] = [1 << 6, 1 << 4, 1 << 2, 1 << 0];
const SHIFTS2: [u8; 4] = [2 << 6, 2 << 4, 2 << 2, 2 << 0];

const fn set_bits(b: u8, pos: u8, val: u8) -> u8 {
    let b = b & MASKS[pos as usize];
    match val {
        1 => b | SHIFTS1[pos as usize],
        2 => b | SHIFTS2[pos as usize],
        _ => b,
    }
}

fn set_c(board: &mut Board, offs: usize, pos: u8, c: u8) {
    let b = &mut board[offs];
    *b = set_bits(*b, pos, c);
}

fn east(offs: usize, pos: u8, i: usize, j: usize, size: (usize, usize)) -> (usize, u8, u8) {
    if i < size.0 - 1 {
        let new_pos = (pos + 1) & 3;
        let new_offs = offs + if new_pos == 0 { 1 } else { 0 };
        (new_offs, new_pos, EAST)
    } else {
        (offs - i / 4, 0, EAST)
    }
}

fn south(offs: usize, pos: u8, i: usize, j: usize, size: (usize, usize)) -> (usize, u8, u8) {
    if j < size.1 - 1 {
        let new_offs = offs + ROW_SIZE;
        (new_offs, pos, SOUTH)
    } else {
        (i / 4, pos, SOUTH)
    }
}

fn mv_dir(
    board: &Board,
    new_board: &mut Board,
    size: (usize, usize),
    dir_cb: fn(usize, u8, usize, usize, (usize, usize)) -> (usize, u8, u8),
) -> bool {
    *new_board = *board;
    let mut moved = false;
    let mut offs = 0;
    let mut pos: u8 = 0;

    for j in 0..size.1 {
        for i in 0..size.0 {
            let c = get_c(board, offs, pos as u8);

            let (new_offs, new_pos, val) = dir_cb(offs, pos, i, j, size);

            let nc = get_c(board, new_offs, new_pos as u8);
            if c == val && nc == 0 {
                set_c(new_board, new_offs, new_pos as u8, val);
                set_c(new_board, offs, pos as u8, 0);
                moved = true;
            }

            pos = (pos + 1) & 3;
            if pos == 0 {
                offs += 1;
            }
        }
        if pos != 0 {
            pos = 0;
            offs += 1;
        }
    }
    moved
}

fn main() {
    let mut board1 = INPUT;
    let mut board2: Board = [0; INPUT_SIZE.1 * ROW_SIZE];

    let mut display = ui::Display::default();
    let mut cnt: usize = 0;
    loop {
        let moved1 = mv_dir(&board1, &mut board2, INPUT_SIZE, east);
        display.show(&board2, cnt, EAST);

        let moved2 = mv_dir(&board2, &mut board1, INPUT_SIZE, south);
        cnt += 1;

        display.show(&board1, cnt, SOUTH);
        let moved = moved1 || moved2;

        // if cnt == 10 {break;}
        if !moved {
            break;
        }
    }
}
