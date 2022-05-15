#![no_std]
#![feature(start)]

utils::entry!(main);

use ufmt_stdio::*;

use arrayvec::ArrayVec;

const BITS: usize = 12;

type Input = ArrayVec<u16, 1000>;

fn most_common(lines: &Input) -> u16 {
    let mut counters = [0; BITS];
    for line in lines {
        for index in 0..BITS {
            counters[index] += (*line >> index) & 1;
        }
    }
    counters
        .iter()
        .enumerate()
        .map(|(index, &v)| {
            if v >= lines.len() as u16 - v {
                1 << index
            } else {
                0
            }
        })
        .fold(0, |acc, v| acc | v as u16)
}

fn main() {
    let lines: Input = utils::iter_lines!("input.txt")
        .map(|line| u16::from_str_radix(utils::to_str(line), 2).unwrap())
        .collect();

    const MASK: u16 = (1 << BITS) - 1;

    let gamma = most_common(&lines);
    let epsilon = (!gamma) & MASK;

    println!("part1: {}", gamma as i32 * epsilon as i32);

    let mut input = lines.clone();
    for bit_index in (0..BITS).rev() {
        let cnt = most_common(&input);
        input = input
            .iter()
            .filter(|&&l| ((l ^ cnt) >> bit_index) & 1 == 0)
            .cloned()
            .collect();
        print!(".");
        if input.len() == 1 {
            break;
        }
    }

    let o2 = input[0];

    let mut input = lines.clone();
    for bit_index in (0..BITS).rev() {
        let cnt = most_common(&input);
        input = input
            .iter()
            .filter(|&&l| ((l ^ cnt) >> bit_index) & 1 == 1)
            .cloned()
            .collect();
        print!(".");
        if input.len() == 1 {
            break;
        }
    }
    let co2 = input[0];

    println!("\npart2: {}", o2 as u32 * co2 as u32);
}
