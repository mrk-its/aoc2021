#![no_std]
#![feature(start)]

utils::entry!(main);
extern crate alloc;
extern crate mos_alloc;
use core::cell::RefCell;

use alloc::rc::Rc;
use alloc::vec::Vec;

use ufmt_stdio::*;

type Int = u16;

#[derive(Debug, Clone, PartialEq, Eq)]
struct SNum {
    int: Rc<RefCell<SNumInt>>,
}

#[derive(Debug, Clone, PartialEq, Eq)]
enum SNumInt {
    Regular(Int),
    Pair((SNum, SNum)),
}

impl SNumInt {
    fn deep_clone(&self) -> Self {
        match self {
            SNumInt::Regular(_) => self.clone(),
            SNumInt::Pair((l, r)) => SNumInt::Pair((
                l.deep_clone(), r.deep_clone()
            ))
        }
    }
}

impl SNum {
    fn new(int: SNumInt) -> Self {
        Self {
            int: Rc::new(RefCell::new(int)),
        }
    }
    fn deep_clone(&self) -> Self {
        SNum::new(self.int.borrow().deep_clone())
    }

    fn repl(&self, v: SNumInt) -> SNumInt {
        self.int.replace(v)
    }
    fn add(&self, other: &SNum) -> SNum {
        SNum::new(SNumInt::Pair((self.clone(), other.clone()))).reduce()
    }
    fn reduce(&self) -> SNum {
        let result = self.deep_clone();
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
        let mut repl = None;
        let ret = {
            let x = &*(*self.int).borrow();
            match &x {
                SNumInt::Regular(x) => {
                    if *x > 9 {
                        let a = *x / 2;
                        let b = *x - a;
                        repl = Some(SNumInt::Pair((
                            SNum::new(SNumInt::Regular(a)),
                            SNum::new(SNumInt::Regular(b)),
                        )));
                        true
                    } else {
                        false
                    }
                }
                SNumInt::Pair(pair) => pair.0.split() || pair.1.split(),
            }
        };
        if let Some(repl) = repl {
            self.repl(repl);
        }
        ret
    }
    fn _explode(
        &self,
        depth: i32,
        exploded: &mut Option<SNum>,
        left: &mut Option<SNum>,
        right: &mut Option<SNum>,
    ) {
        let mut repl = false;
        {
            let x = &*(*self.int).borrow();
            match &x {
                SNumInt::Regular(_) => {
                    if exploded.is_none() {
                        left.replace(self.clone());
                    } else if right.is_none() {
                        right.replace(self.clone());
                    }
                }
                SNumInt::Pair(pair) => {
                    if depth == 0 && exploded.is_none() {
                        let l = &*(*pair.0.int).borrow();
                        let r = &*(*pair.1.int).borrow();
                        match &(l, r) {
                            (SNumInt::Regular(_), SNumInt::Regular(_)) => {
                                repl = true;
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
        if repl {
            exploded.replace(SNum::new(self.repl(SNumInt::Regular(0))));
        }
    }

    fn explode(&self) -> bool {
        let mut exploded: Option<SNum> = None;
        let mut left: Option<SNum> = None;
        let mut right: Option<SNum> = None;

        let mut left_replacement = None;
        let mut right_replacement = None;

        {
            self._explode(4, &mut exploded, &mut left, &mut right);
            let exploded = match exploded {
                Some(v) => v,
                None => {
                    return false;
                }
            };
            let x = &*(*exploded.int).borrow();
            // println!("exploded pair: {:?}, left: {:?}, right: {:?}", exploded, left, right);
            match x {
                SNumInt::Pair(p) => {
                    let l = &*(*p.0.int).borrow();
                    let r = &*(*p.1.int).borrow();
                    let (l, r) = if let (SNumInt::Regular(l), SNumInt::Regular(r)) = (l, r) {
                        (l, r)
                    } else {
                        println!("pair with non-regular numbers");
                        panic!();
                    };

                    if let Some(x) = &left {
                        let x = &*(*x.int).borrow();
                        if let SNumInt::Regular(a) = x {
                            left_replacement.replace(*a + l);
                        }
                    };

                    if let Some(x) = &right {
                        let x = &*(*x.int).borrow();
                        if let SNumInt::Regular(a) = x {
                            right_replacement.replace(*a + r);
                        }
                    }
                    true
                }
                _ => panic!("wrong exploded"),
            };
        }
        if let Some(a) = left_replacement {
            left.as_mut().unwrap().repl(SNumInt::Regular(a));
        }
        if let Some(a) = right_replacement {
            right.as_mut().unwrap().repl(SNumInt::Regular(a));
        }

        true
    }
    fn magnitude(&self) -> Int {
        match &*(*self.int).borrow() {
            SNumInt::Regular(x) => *x,
            SNumInt::Pair(pair) => 3 * pair.0.magnitude() + 2 * pair.1.magnitude(),
        }
    }
}

fn parse_line<'a>(input: &mut impl Iterator<Item = &'a u8>) -> SNum {
    let c = *input.next().unwrap();
    if c >= 48 && c < 48 + 10 {
        SNum::new(SNumInt::Regular(c as Int - 48))
    } else if c == b'[' {
        let left = parse_line(input);
        assert_eq!(*input.next().unwrap(), b',');
        let right = parse_line(input);
        assert_eq!(*input.next().unwrap(), b']');
        SNum::new(SNumInt::Pair((left, right)))
    } else {
        println!("parse panic!");
        panic!()
    }
}

fn main() {
    #[cfg(target_arch = "mos")]
    mos_alloc::set_limit(48000);

    let input = utils::iter_lines!("input.txt")
        .map(|line| parse_line(&mut line.iter()))
        .collect::<Vec<_>>();
    println!("parsed!");
    let mut iter = input.iter();
    let mut result = iter.next().unwrap().clone();

    for n in iter {
        result = result.add(n);
    }
    let part1 = result.magnitude();
    println!("part1: {}", part1);
    assert_eq!(part1, 3725);
    let mut max = 0;
    for (i, a) in input.iter().enumerate() {
        for (j, b) in input.iter().enumerate() {
            if i != j {
                max = a.add(b).magnitude().max(max);
            }
        }
    }
    println!("part2: {}", max);
    assert_eq!(max, 4832);
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
