#![no_std]
#![feature(start)]
utils::entry!(main);

use ufmt_stdio::*;

fn main() {
    let mut pos = 0;
    let mut depth = 0;
    println!("start!\n");
    let parsed = include_str!("input.txt").split('\n').map(|line| {
        let mut p = line.split(' ');
        let dir = p.next().unwrap();
        let n = p.next().unwrap();
        (dir, n.parse::<u8>().unwrap())
    });

    // string pattern matching doesn't work!
    //

    for (dir, n) in parsed.clone() {
        let n = n as i32;
        match dir {
            "forward" => pos += n,
            "down" => depth += n,
            "up" => depth -= n,
            _ => panic!(),
        }
    }

    println!("part1: {}", pos * depth);

    let mut pos = 0;
    let mut depth = 0;
    let mut aim = 0;

    for (dir, n) in parsed.clone() {
        let n = n as u32;
        match dir {
            "forward" => {
                pos += n;
                depth += aim * n;
            }
            "down" => aim += n,
            "up" => aim -= n,
            _ => panic!(),
        }
    }
    println!("part2: {}", pos * depth);
}
