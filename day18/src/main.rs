#![no_std]
#![feature(start)]
#![feature(default_alloc_error_handler)]

utils::entry!(main);
extern crate alloc;
extern crate mos_alloc;
use alloc::boxed::Box;
use alloc::vec::Vec;

use ufmt_stdio::*;

type Int = u16;

#[derive(Debug, Clone, PartialEq, Eq)]
enum SNum {
    Regular(Int),
    Pair(Box<(SNum, SNum)>),
}

impl SNum {
    fn repl(&self, v: SNum) {
        let mut_ref: &mut SNum = unsafe { core::mem::transmute(self as *const SNum) };
        *mut_ref = v;
    }
    fn pair(a: SNum, b: SNum) -> SNum {
        SNum::Pair(Box::new((a, b)))
    }
    fn add(&self, other: &SNum) -> SNum {
        SNum::Pair(Box::new((self.clone(), other.clone()))).reduce()
    }
    fn reduce(&self) -> SNum {
        let result = self.clone();
        loop {
            if result.explode() {
                // println!("exploded: {:?}", self);
                continue;
            }
            if result.split() {
                // println!("splitted: {:?}", self);
                continue;
            }
            break;
        }
        result
    }
    fn split(&self) -> bool {
        match self {
            SNum::Regular(x) => {
                if *x > 9 {
                    let a = *x / 2;
                    let b = *x - a;
                    self.repl(SNum::Pair(Box::new((SNum::Regular(a), SNum::Regular(b)))));
                    true
                } else {
                    false
                }
            }
            SNum::Pair(pair) => pair.0.split() || pair.1.split(),
        }
    }
    fn _explode<'a>(
        &'a self,
        depth: i32,
        exploded: &mut Option<SNum>,
        left: &mut Option<&'a SNum>,
        right: &mut Option<&'a SNum>,
    ) {
        match self {
            SNum::Regular(x) => {
                if exploded.is_none() {
                    *left = Some(self)
                } else if right.is_none() {
                    *right = Some(self)
                }
            }
            SNum::Pair(pair) => {
                if depth == 0 && exploded.is_none() {
                    match &**pair {
                        (SNum::Regular(_), SNum::Regular(_)) => {
                            *exploded = Some(self.clone());
                            self.repl(SNum::Regular(0));
                        }
                        _ => (),
                    }
                } else {
                    pair.0._explode(depth - 1, exploded, left, right);
                    pair.1._explode(depth - 1, exploded, left, right);
                }
            }
        }
    }
    fn explode(&self) -> bool {
        let mut exploded: Option<SNum> = None;
        let mut left: Option<&SNum> = None;
        let mut right: Option<&SNum> = None;
        self._explode(4, &mut exploded, &mut left, &mut right);
        // println!("exploded pair: {:?}, left: {:?}, right: {:?}", exploded, left, right);
        match exploded {
            Some(SNum::Pair(p)) => {
                let (l, r) = if let (SNum::Regular(l), SNum::Regular(r)) = *p {
                    (l, r)
                } else {
                    panic!("pair with non-regular numbers");
                };

                if let Some(SNum::Regular(a)) = left {
                    left.unwrap().repl(SNum::Regular(*a + l))
                }
                if let Some(SNum::Regular(a)) = right {
                    right.unwrap().repl(SNum::Regular(*a + r))
                }

                true
            }
            None => false,
            _ => panic!("wrong exploded"),
        }
    }
    fn magnitude(&self) -> Int {
        match self {
            SNum::Regular(x) => *x,
            SNum::Pair(pair) => 3 * pair.0.magnitude() + 2 * pair.1.magnitude(),
        }
    }
}

fn parse_line<'a>(input: &mut impl Iterator<Item = &'a u8>) -> SNum {
    let c = *input.next().unwrap();
    if c >= 48 && c < 48 + 10 {
        SNum::Regular(c as Int - 48)
    } else if c == b'[' {
        let left = parse_line(input);
        assert_eq!(*input.next().unwrap(), b',');
        let right = parse_line(input);
        assert_eq!(*input.next().unwrap(), b']');
        SNum::Pair(Box::new((left, right)))
    } else {
        panic!()
    }
}

fn main() {
    mos_alloc::set_limit(16384);
    let input = utils::iter_lines!("input.txt")
        .map(|line| parse_line(&mut line.iter()))
        .collect::<Vec<_>>();
    println!("parsed!");
    let mut iter = input.iter();
    let mut result = iter.next().unwrap().clone();

    for n in iter {
        result = result.add(n);
    }

    println!("part1: {}", result.magnitude());
    let mut max = 0;
    for (i, a) in input.iter().enumerate() {
        for (j, b) in input.iter().enumerate() {
            if i != j {
                max = a.add(b).magnitude().max(max);
            }
        }
    }
    println!("part2: {}", max);
}

#[test]
fn test_parse1() {
    parse("[1,2]");
}

#[test]
fn test_split1() {
    let mut n = SNum::Regular(11);
    assert!(n.split());
    assert_eq!(n, SNum::pair(SNum::Regular(5), SNum::Regular(6)));
}

#[test]
fn test_split2() {
    let mut n = SNum::Regular(9);
    assert!(!n.split());
    assert_eq!(n, SNum::Regular(9));
}

#[test]
fn test_split3() {
    let mut n = SNum::pair(SNum::Regular(10), SNum::Regular(10));
    assert!(n.split());
    assert_eq!(
        n,
        SNum::pair(
            SNum::pair(SNum::Regular(5), SNum::Regular(5)),
            SNum::Regular(10)
        )
    );
}

#[test]
fn test_split4() {
    let mut n = SNum::pair(SNum::Regular(1), SNum::Regular(10));
    assert!(n.split());
    assert_eq!(
        n,
        SNum::pair(
            SNum::Regular(1),
            SNum::pair(SNum::Regular(5), SNum::Regular(5))
        )
    );
}

#[test]
fn test_magnitude() {
    assert_eq!(
        parse("[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]").magnitude(),
        3488
    )
}

#[test]
fn test_explodable1() {
    let n = parse("[[[[[9,8],1],2],3],4]");
    let expl = n.explode();
    assert!(expl);
    assert_eq!(n, parse("[[[[0,9],2],3],4]"));
}

#[test]
fn test_explodable2() {
    let n = parse("[7,[6,[5,[4,[3,2]]]]]");
    let expl = n.explode();
    assert!(expl);
    assert_eq!(n, parse("[7,[6,[5,[7,0]]]]"));
}
#[test]
fn test_explodable3() {
    let n = parse("[[6,[5,[4,[3,2]]]],1]");
    let expl = n.explode();
    assert!(expl);
    assert_eq!(n, parse("[[6,[5,[7,0]]],3]"));
}

#[test]
fn test_explodable4() {
    let n = parse("[[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]");
    let expl = n.explode();
    assert!(expl);
    assert_eq!(n, parse("[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]"));
}

#[test]
fn test_explodable5() {
    let n = parse("[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]");
    let expl = n.explode();
    assert!(expl);
    assert_eq!(n, parse("[[3,[2,[8,0]]],[9,[5,[7,0]]]]"));
}

#[test]
fn test_add() {
    let a = parse("[[[[4,3],4],4],[7,[[8,4],9]]]");
    let b = parse("[1,1]");
    let c = a.add(&b);
    assert_eq!(c, parse("[[[[0,7],4],[[7,8],[6,0]]],[8,1]]"));
}
