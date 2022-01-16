#![no_std]
#![feature(start)]

utils::entry!(main);
use ufmt_stdio::*;

#[derive(Copy, Clone)]
struct Board {
    rows: [[u8; 5]; 5],
    positions: [u8; 100],
    marked: [u8; 13], // 104 bits, we need 100
    row_cnt: [u8; 5],
    col_cnt: [u8; 5],
    last_value: u8,
    win: bool,
}

impl Default for Board {
    fn default() -> Self {
        Self {
            win: false,
            rows: Default::default(),
            positions: [0xff; 100],
            marked: [0; 13],
            row_cnt: [0; 5],
            col_cnt: [0; 5],
            last_value: 0,
        }
    }
}

fn parse_row(row: &str, parsed: &mut [u8; 5]) {
    for (i, v) in row
        .split(' ')
        .filter(|v| !v.is_empty())
        .map(|v| v.parse().unwrap())
        .enumerate()
    {
        parsed[i] = v;
    }
}

fn is_bit_set(bits: &[u8], index: usize) -> bool {
    let idx = (index >> 3) as usize;
    let bit_pos = index & 7;
    return bits[idx] & (1 << bit_pos) != 0;
}

impl Board {
    fn init(&mut self, data: &str) {
        for (i, row) in data.split('\n').enumerate() {
            // it fails in release mode when changed to "\n"
            parse_row(row, &mut self.rows[i]);
        }

        for (j, row) in self.rows.iter().enumerate() {
            for (i, v) in row.iter().enumerate() {
                self.positions[*v as usize] = (j << 3 | i) as u8;
            }
        }
    }

    fn mark(&mut self, value: u8) -> bool {
        self.last_value = value;
        let idx = (value >> 3) as usize;
        let bit_pos = value & 7;
        self.marked[idx] |= 1 << bit_pos;
        let pos = self.positions[value as usize];
        if pos != 0xff {
            let j = pos >> 3;
            let i = pos & 7;
            self.row_cnt[j as usize] += 1;
            self.col_cnt[i as usize] += 1;
            self.win = self.row_cnt[j as usize] == 5 || self.col_cnt[i as usize] == 5;
        }
        return self.win;
    }
    fn score(&self) -> u16 {
        // after changing to i32 it fails on parsing header (wher this function is not called yet !??)
        let sum = self
            .rows
            .iter()
            .flat_map(|v| v.iter())
            .filter(|v| !is_bit_set(&self.marked, **v as usize))
            .fold(0, |acc, v| acc + *v as u16);
        sum * self.last_value as u16
    }
}

const BOARD_COUNT: usize = 100;
const NUMBER_COUNT: usize = 100;

fn main() {
    // part1: 29440
    // part2: 13884
    let data = include_str!("input.txt");
    print!("parsing header...");
    let mut data = data.split("\n\n");
    let header = data.next().unwrap();

    let mut numbers: [u8; NUMBER_COUNT] = [0; NUMBER_COUNT];
    let mut boards: [Board; BOARD_COUNT] = [Board::default(); BOARD_COUNT];

    for (i, v) in header
        .split(',')
        .map(|v| v.parse::<u8>().unwrap())
        .enumerate()
    {
        numbers[i] = v;
    }
    print!("done\nparsing boards...");

    for (i, board_data) in data.enumerate() {
        print!(".");
        boards[i].init(board_data);
    }
    print!("done\nplaying...");
    let mut first_score = None;
    let mut last_score = 0;

    for &value in numbers.iter() {
        for board in boards.iter_mut() {
            if !board.win && board.mark(value) {
                last_score = board.score();
                if first_score.is_none() {
                    first_score = Some(last_score);
                }
                print!(".");
            }
        }
    }

    println!("\npart1: {}", first_score.unwrap());
    println!("part2: {}", last_score);
}
