#![no_std]
#![feature(start)]

utils::entry!(main);
extern crate alloc;
extern crate mos_alloc;

use core::slice::Iter;

use alloc::vec::Vec;
use ufmt_stdio::*;

use itertools::{put_back, PutBack};

enum ChunkError {
    Incomplete(Vec<u8>),
    Corrupted(u8),
}

fn read_chunks(chars: &mut PutBack<Iter<u8>>, stack: &mut Vec<u8>) -> Result<bool, ChunkError> {
    loop {
        let is_empty = read_chunk(chars, stack)?;
        if is_empty {
            break;
        }
    }
    return Ok(false);
}

fn is_closing(c: &u8) -> bool {
    [b'}', b'>', b')', b']'].contains(c)
}

fn get_closing(c: u8) -> u8 {
    match c {
        b'{' => b'}',
        b'<' => b'>',
        b'(' => b')',
        b'[' => b']',
        _ => panic!(),
    }
}

fn read_chunk(chars: &mut PutBack<Iter<u8>>, stack: &mut Vec<u8>) -> Result<bool, ChunkError> {
    let s = chars.next();
    let s = match s {
        Some(s) => s,
        None => return Ok(true), // empty chunk, end of chars
    };
    if is_closing(s) {
        chars.put_back(s);
        return Ok(true); // emptu chunk, next char is closing
    }
    let expected_end = get_closing(*s);
    stack.push(expected_end);
    read_chunks(chars, stack)?;

    let e = match chars.next() {
        Some(c) => c,
        None => {
            return Err(ChunkError::Incomplete(
                stack.iter().cloned().rev().collect(),
            ))
        }
    };

    if *e != get_closing(*s) {
        return Err(ChunkError::Corrupted(*e));
    };
    stack.pop();
    return Ok(false);
}

fn main() {
    let mut sum = 0;
    let mut sums: Vec<i64> = Vec::new();
    for line in utils::iter_lines!("input.txt") {
        let mut iter = put_back(line.iter());
        match read_chunks(&mut iter, &mut Vec::new()) {
            Ok(_) => {
                println!("ok");
            }
            Err(ChunkError::Incomplete(stack)) => {
                let mut sum = 0;
                for c in stack.iter() {
                    sum = sum * 5
                        + match *c {
                            b')' => 1,
                            b']' => 2,
                            b'}' => 3,
                            b'>' => 4,
                            _ => panic!("invalid data"),
                        }
                }
                sums.push(sum);
            }
            Err(ChunkError::Corrupted(e)) => {
                sum += match e {
                    b')' => 3,
                    b']' => 57,
                    b'}' => 1197,
                    b'>' => 25137,
                    _ => panic!("invalid data"),
                };
            }
        }
    }
    println!("part1: {}", sum);
    assert!(sum == 469755);
    sums.sort();
    let part2 = sums[sums.len() / 2];
    println!("part2: {}", part2);
    assert!(part2 == 2762335572);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test1() {}
}
