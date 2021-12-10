use itertools::{Itertools, PutBack, put_back};
use std::{collections::{HashSet, hash_map, HashMap}, str::Chars};

fn parse(input: &str) -> Vec<&str> {
    input
        .split('\n')
        .collect_vec()
}

enum ChunkError {
    Incomplete(Vec<char>),
    Corrupted(char),
}

fn read_chunks(chars: &mut PutBack<Chars>, stack: &mut Vec<char>) -> Result<bool, ChunkError> {
    loop {
        let is_empty = read_chunk(chars, stack)?;
        if is_empty {
            break;
        }
    };
    return Ok(false);
}


fn read_chunk(chars: &mut PutBack<Chars>, stack: &mut Vec<char>) -> Result<bool, ChunkError> {
    let PAIRS: HashMap<char, char> = [('{', '}'), ('<', '>'), ('(', ')'), ('[', ']')].into_iter().collect();
    let OPENING: HashSet<char> = PAIRS.keys().cloned().collect();
    let CLOSING: HashSet<char> = PAIRS.values().cloned().collect();

    let s = chars.next();
    let s = match s {
        Some(s) => s,
        None => return Ok(true)  // empty chunk, end of chars
    };
    if CLOSING.contains(&s) {
        chars.put_back(s);
        return Ok(true)  // emptu chunk, next char is closing
    }
    let expected_end = *PAIRS.get(&s).unwrap();
    stack.push(expected_end);
    read_chunks(chars, stack)?;

    let e = match chars.next() {
        Some(c) => c,
        None => return Err(ChunkError::Incomplete(stack.iter().cloned().rev().collect())),
    };

    if e != *PAIRS.get(&s).unwrap() {
        return Err(ChunkError::Corrupted(e))
    };
    stack.pop();
    return Ok(false);
}

fn main() {
    let parsed = parse(include_str!("input.txt"));
    println!("parsed: {:?}", parsed);
    let mut sum = 0;
    let mut sums: Vec<i64> = vec![];
    for line in parsed {
        print!("{:?} - ", line);
        let mut iter = put_back(line.chars());
        match read_chunks(&mut iter, &mut Vec::new()) {
            Ok(_) => println!("ok"),
            Err(ChunkError::Incomplete(stack)) => {
                println!("incomplete: {:?}", stack.iter().collect::<String>());
                let mut sum = 0;
                for c in stack.iter() {
                    sum = sum * 5 + match *c {
                        ')' => 1,
                        ']' => 2,
                        '}' => 3,
                        '>' => 4,
                        _ => panic!("invalid data")
                    }
                }
                sums.push(sum);
            }
            Err(ChunkError::Corrupted(e)) => {
                sum += match e {
                    ')' => 3,
                    ']' => 57,
                    '}' => 1197,
                    '>' => 25137,
                    _ => panic!("invalid data"),
                };
                println!("corrupted {}", e)
            },
        }
    }
    println!("part1: {}", sum);
    sums.sort();
    println!("part2: {}", sums[sums.len() / 2]);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test1() {}
}
