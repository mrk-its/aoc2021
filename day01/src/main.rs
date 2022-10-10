#![no_std]
#![feature(start)]
#![feature(default_alloc_error_handler)]

extern crate alloc;
extern crate mos_alloc;

utils::entry!(main);

use alloc::vec::Vec;
use ufmt_stdio::*;

// use staticvec::StaticVec;

fn main() {
    let input = utils::iter_lines!("input.txt");

    // let regex = safe_regex::regex!(b".*");

    //print!("parsing...");
    let parser = input.map(|i| {
        unsafe { core::str::from_utf8_unchecked(i) }
            .parse::<i16>()
            .unwrap()
    });

    let mut parsed = Vec::with_capacity(2000);
    parsed.extend(parser);
    //println!("done");

    let part1 = parsed
        .iter()
        .zip(&parsed[1..])
        .filter(|(a, b)| a < b)
        .count();

    println!("part1: {}", part1);
    assert!(part1 == 1564);

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
    assert!(part2 == 1611);
}
