#![no_std]
#![feature(start)]
#![feature(default_alloc_error_handler)]

utils::entry!(main);
extern crate alloc;
extern crate mos_alloc;

use alloc::vec::Vec;
use ufmt_stdio::*;

// use std::collections::HashSet;

type Board = Vec<Vec<u8>>;

const WIDTH: usize = 100;
const HEIGHT: usize = 100;

const VISITED_SIZE: usize = WIDTH * HEIGHT / 8;
type Visited = BitSet<VISITED_SIZE>;

struct BitSet<const N: usize> {
    bits: [u8; N],
}

impl<const N: usize> BitSet<N> {
    fn new() -> Self {
        Self { bits: [0; N] }
    }
    fn contains(&self, index: usize) -> bool {
        let offs = index / 8;
        let bit_offs = index & 7;
        return (self.bits[offs] >> bit_offs) & 1 > 0;
    }
    fn insert(&mut self, index: usize) {
        let offs = index / 8;
        let bit_offs = index & 7;
        self.bits[offs] |= 1 << bit_offs;
    }
}

fn parse_board<'a>(input: impl Iterator<Item = &'a [u8]>) -> Board {
    input
        .map(|line| line.iter().map(|b| (b - 48) as u8).collect::<Vec<_>>())
        .collect::<Vec<_>>()
}

fn board_size(board: &Board) -> (usize, usize) {
    let w = board[0].len();
    let h = board.len();
    (w, h)
}

fn neighbours_min(board: &Board, x: usize, y: usize) -> u8 {
    let mut min = 9;
    let (w, h) = board_size(board);
    for (x, y) in neighbours(x, y, w, h) {
        min = board[y][x].min(min);
    }
    min
}

fn neighbours(x: usize, y: usize, w: usize, h: usize) -> impl Iterator<Item = (usize, usize)> {
    let x = x as i32;
    let y = y as i32;
    [(-1, 0), (1, 0), (0, -1), (0, 1)]
        .iter()
        .map(move |(kx, ky)| ((x + kx) as usize, (y + ky) as usize))
        .filter(move |(x, y)| *x < w && *y < h)
}

fn basin_area(board: &Board, x: usize, y: usize) -> i32 {
    let mut visited = Visited::new();
    let (w, h) = board_size(board);

    if board[y][x] == 9 {
        return 0;
    }

    let mut area = 0;

    let mut queue = Vec::new();
    queue.push((x, y));
    visited.insert(y * w + x);

    while !queue.is_empty() {
        let (x, y) = queue.remove(0);
        area += 1;
        for (x, y) in neighbours(x, y, w, h) {
            if !visited.contains(y * w + x) && board[y][x] != 9 {
                queue.push((x, y));
                visited.insert(y * w + x);
            }
        }
    }
    area
}

fn low_points(board: &Board) -> Vec<(usize, usize)> {
    let mut points = Vec::new();
    for (y, row) in board.iter().enumerate() {
        for (x, v) in row.iter().enumerate() {
            if *v < neighbours_min(&board, x, y) {
                points.push((x, y));
            }
        }
    }
    points
}

fn main() {
    mos_alloc::set_limit(15000);

    let board = parse_board(utils::iter_lines!("input.txt"));
    let mut sum: u16 = 0;
    for (x, y) in low_points(&board) {
        sum += 1 + board[y][x] as u16
    }
    println!("part1: {}", sum);

    let mut areas: Vec<(i32, usize, usize)> = Vec::new();

    for (x, y) in low_points(&board) {
        areas.push((basin_area(&board, x, y), x, y));
    }
    areas.sort_by_key(|k| -k.0);
    let result = &areas[0..3].iter().map(|v| v.0).fold(1, |a, v| a * v);
    println!("part2: {}", result);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test1() {}
}
