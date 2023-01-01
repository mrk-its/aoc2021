#![no_std]
#![feature(start)]

utils::entry!(main);
extern crate alloc;
extern crate mos_alloc;

use alloc::vec::Vec;
use ufmt::derive::uDebug;
use ufmt_stdio::*;

// use std::collections::{HashMap, HashSet};

#[derive(PartialEq, Eq, Copy, Clone, uDebug)]
struct Display {
    digits: u8,
}

impl Display {
    pub fn new(digits: u8) -> Self {
        Self { digits }
    }
    pub fn len(&self) -> usize {
        let mut mask: u8 = 1;
        let mut cnt = 0;
        while mask > 0 {
            if self.digits & mask > 0 {
                cnt += 1;
            }
            mask = mask.wrapping_add(mask);
        }
        cnt
    }

    pub fn intersection(&self, other: &Display) -> Display {
        Display::new(self.digits & other.digits)
    }

    pub fn difference(&self, other: &Display) -> Display {
        Display::new(self.digits & !other.digits)
    }
    pub fn get(&self) -> u8 {
        let mut mask: u8 = 1;
        while mask > 0 {
            if self.digits & mask > 0 {
                return mask;
            }
            mask = mask.wrapping_add(mask);
        }
        return 0;
    }
    pub fn contains(&self, value: u8) -> bool {
        self.digits & value > 0
    }
}

// type Display = HashSet<char>;

fn parse_display(input: &[u8]) -> Display {
    let mut digits: u8 = 0;
    for c in input.iter() {
        digits |= 1 << (*c - b'a');
    }
    Display::new(digits)
}

fn parse_displays(input: &[u8]) -> Vec<Display> {
    input
        .split(|c| *c == b' ')
        .filter(|d| d.len() > 0)
        .map(parse_display)
        .collect::<Vec<Display>>()
}

fn parse_line(line: &[u8]) -> (Vec<Display>, Vec<Display>) {
    let mut parts = line.split(|c| *c == b'|');
    let left = parts.next().unwrap();
    let right = parts.next().unwrap();
    (parse_displays(left), parse_displays(right))
}

fn parse<'a>(input: impl Iterator<Item = &'a [u8]>) -> Vec<(Vec<Display>, Vec<Display>)> {
    input
        .map(parse_line)
        .collect::<Vec<(Vec<Display>, Vec<Display>)>>()
}

fn decode(input: &Vec<Display>, out: &Vec<Display>) -> u32 {
    let mut by_len = [
        Vec::default(),
        Vec::default(),
        Vec::default(),
        Vec::default(),
        Vec::default(),
        Vec::default(),
        Vec::default(),
        Vec::default(),
    ];

    for d in input {
        by_len[d.len()].push(d)
    }

    let d1: &Display = by_len[2][0];
    let d4: &Display = by_len[4][0];
    let d8: &Display = by_len[7][0];
    let d7: &Display = by_len[3][0];

    let d3 = *by_len
        .get(5)
        .and_then(|items| {
            items
                .iter()
                .filter(|c| c.intersection(&d1).len() == 2)
                .next()
        })
        .expect("bla");
    let d6 = *by_len
        .get(6)
        .and_then(|items| {
            items
                .iter()
                .filter(|c| c.intersection(&d1).len() == 1)
                .next()
        })
        .unwrap();

    let top_right = d8.difference(d6).get();

    let d2 = *by_len
        .get(5)
        .and_then(|items| {
            items
                .iter()
                .filter(|c| **c != d3 && c.contains(top_right))
                .next()
        })
        .unwrap();
    let d5 = *by_len
        .get(5)
        .and_then(|f| {
            f.iter()
                .filter(|c| **c != d3 && !c.contains(top_right))
                .next()
        })
        .unwrap();

    let d9 = *by_len
        .get(6)
        .and_then(|f| {
            f.iter()
                .filter(|c| c.intersection(d3).len() == d3.len())
                .next()
        })
        .unwrap();

    let d0 = *by_len
        .get(6)
        .and_then(|f| f.iter().filter(|c| **c != d9 && **c != d6).next())
        .unwrap();

    let digits = [d0, d1, d2, d3, d4, d5, d6, d7, d8, d9];

    let out = out
        .iter()
        .flat_map(|c| digits.iter().enumerate().filter(|(_, x)| ***x == *c).next())
        .map(|v| v.0)
        .collect::<Vec<usize>>();
    let out = out
        .iter()
        .enumerate()
        .map(|c| *c.1 as u32 * 10u32.pow(3 - c.0 as u32))
        .collect::<Vec<_>>();
    out.iter().fold(0, |a, v| a + v)
}

fn main() {
    #[cfg(target_arch="mos")]
    mos_alloc::set_limit(12000);
    let data = parse(utils::iter_lines!("input.txt"));
    let mut cnt = 0;

    let lengths = [2, 4, 3, 7];
    for (_, out) in &data {
        cnt += out.iter().filter(|c| lengths.contains(&c.len())).count();
    }
    println!("part1: {:?}", cnt);
    assert!(cnt == 344);

    let mut sum = 0;
    for (input, out) in &data {
        sum += decode(input, out);
    }
    println!("part2: {:?}", sum);
    assert!(sum == 1048410);
}

#[cfg(test)]
mod tests {
    use super::*;

    const TEST_DATA: &str =
        "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf";

    #[test]
    fn test1() {
        let data = parse(TEST_DATA);

        let (input, out) = &data[0];
        assert!(decode(&input, &out) == 5353);
    }
}
