#![no_std]
#![feature(start)]
utils::entry!(main);

use ufmt_stdio::*;

fn main() {
    let mut pos = 0;
    let mut depth = 0;

    let parsed = utils::iter_lines!("input.txt").map(|line| {
        let mut p = line.split(|f| *f == 32);
        let dir = p.next().unwrap();
        let n = utils::to_str(p.next().unwrap());
        (dir, n.parse::<u8>().unwrap())
    });

    // string pattern matching doesn't work!
    //

    for (dir, n) in parsed.clone() {
        let n = n as i32;
        match dir {
            b"forward" => pos += n,
            b"down" => depth += n,
            b"up" => depth -= n,
            _ => panic!(),
        }
    }
    let part1 = pos * depth;
    println!("part1: {}", part1);

    // WTF: assert below hangs execution in release mode!
    assert!(part1 == 2019945);

    let mut pos = 0;
    let mut depth = 0;
    let mut aim = 0;

    for (dir, n) in parsed.clone() {
        let n = n as u32;
        match dir {
            b"forward" => {
                pos += n;
                depth += aim * n;
            }
            b"down" => aim += n,
            b"up" => aim -= n,
            _ => panic!(),
        }
    }
    let part2 = pos * depth;
    println!("part2: {}", part2);
    assert!(part2 == 1599311480);
}
