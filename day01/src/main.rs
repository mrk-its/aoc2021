#![no_std]
#![feature(start)]
utils::entry!(main);

use ufmt_stdio::*;

use staticvec::StaticVec;

fn main() {
    let input = include_str!("input.txt");

    // let regex = safe_regex::regex!(b".*");

    print!("parsing...");
    let parsed = input
        .split('\n')
        .map(|i| i.parse::<i16>().unwrap())
        .collect::<StaticVec<i16, 2000>>();
    println!("done");

    let part1 = parsed
        .iter()
        .zip(&parsed[1..])
        .filter(|(a, b)| a < b)
        .count();

    println!("part1: {}", part1);

    let values = parsed
        .iter()
        .zip(&parsed[1..])
        .zip(&parsed[2..])
        .map(|((a, b), c)| a + b + c);
    let part2 = values
        .clone()
        .zip(values.skip(1))
        .filter(|(a, b)| b > a)
        .count();
    println!("part2: {}", part2);
}
