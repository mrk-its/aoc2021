#![no_std]
#![feature(start)]
#![feature(default_alloc_error_handler)]

extern crate alloc;
extern crate mos_alloc;

use alloc::vec::Vec;
use bstr::ByteSlice;
use ufmt_stdio::*;

utils::entry!(main);

const WIDTH: usize = 1024;
const HEIGHT: usize = 64;

struct Board {
    data: [u8; WIDTH / 4 * HEIGHT],
}

impl Default for Board {
    fn default() -> Self {
        Self {
            data: [0; WIDTH / 4 * HEIGHT],
        }
    }
}

impl Board {
    pub fn set(&mut self, coords: (i16, i16)) -> bool {
        let offs = coords.1 as usize * (WIDTH / 4) + coords.0 as usize / 4;
        let bit_pos = (coords.0 & 3) * 2;

        let inp = self.data[offs];
        let mut v = (inp >> bit_pos) & 3;
        v = (v + 1).min(3);

        self.data[offs] = inp & !(3 << bit_pos) | (v << bit_pos);
        v == 2
    }
}

fn point(board: &mut Board, coords: (i16, i16), cnt: &mut u32) {
    if coords.1 >= 0 && coords.1 < (HEIGHT as i16) && board.set(coords) {
        *cnt += 1;
    }
}

fn draw(board: &mut Board, mut p1: (i16, i16), p2: (i16, i16), cnt: &mut u32) {
    let dx = (p2.0 - p1.0).signum();
    let dy = (p2.1 - p1.1).signum();

    loop {
        point(board, p1, cnt);
        if p1 == p2 {
            return;
        }
        p1 = (p1.0 + dx, p1.1 + dy);
    }
}

fn get_input() -> impl Iterator<Item = ((i16, i16), (i16, i16))> {
    utils::iter_lines!("input.txt")
        .map(|row| {
            row.split_str(b" -> ")
                .map(|coords| {
                    coords
                        .split_str(b",")
                        .map(|v| utils::to_str(v).parse::<i16>().unwrap())
                        .collect::<Vec<_>>()
                })
                .collect::<Vec<_>>()
        })
        .map(|line| ((line[0][0], line[0][1]), (line[1][0], line[1][1])))
}

fn main() {
    // mos_alloc::set_limit(8192);
    // let parsed = utils::iter_lines!("input.txt")
    //     .map(|row| {
    //         row.split_str(b" -> ")
    //             .map(|coords| {
    //                 coords
    //                     .split_str(b",")
    //                     .map(|v| utils::to_str(v).parse::<i16>().unwrap())
    //                     .collect::<Vec<_>>()
    //             })
    //             .collect::<Vec<_>>()
    //     })
    //     .map(|line| ((line[0][0], line[0][1]), (line[1][0], line[1][1])))
    //     .collect::<Vec<_>>();

    let mut count = 0;

    for slice in 0..16 {
        let y_offs = slice * HEIGHT as i16;
        let mut board = Board::default();
        for (p1, p2) in get_input().filter(|(p1, p2)| p1.0 == p2.0 || p1.1 == p2.1) {
            draw(
                &mut board,
                (p1.0, p1.1 - y_offs),
                (p2.0, p2.1 - y_offs),
                &mut count,
            );
        }
    }
    println!("part1: {}", count);
    assert!(count == 5442);

    let mut count = 0;

    for slice in 0..16 {
        let y_offs = slice * HEIGHT as i16;
        let mut board = Board::default();
        for (p1, p2) in get_input() {
            draw(
                &mut board,
                (p1.0, p1.1 - y_offs),
                (p2.0, p2.1 - y_offs),
                &mut count,
            );
        }
    }

    println!("part2: {}", count);
    assert!(count == 19571);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test1() {
        let mut board = Board::default();
        let mut cnt = 0;
        draw(&mut board, (0, 0), (0, 0), &mut cnt);
        draw(&mut board, (0, 0), (0, 1), &mut cnt);
        println!("board: {:?}", board);
    }
}
