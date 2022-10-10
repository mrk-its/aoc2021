#![no_std]
#![feature(start)]
#![feature(default_alloc_error_handler)]

utils::entry!(main);
extern crate alloc;
extern crate mos_alloc;

use safe_regex::regex;
use ufmt_stdio::*;

type Num = i16;
type Vec2 = (Num, Num);

fn add(a: Vec2, b: Vec2) -> Vec2 {
    (a.0 + b.0, a.1 + b.1)
}

fn in_target(pos: Vec2, t1: Vec2, t2: Vec2) -> bool {
    pos.0 >= t1.0 && pos.0 <= t2.0 && pos.1 >= t1.1 && pos.1 <= t2.1
}

fn sim(start_v: Vec2, t1: Vec2, t2: Vec2) -> (bool, Num) {
    let mut v = start_v;
    let mut pos = (0, 0);
    let mut max_y = pos.1;
    loop {
        if in_target(pos, t1, t2) {
            // println!("start_v: {:?}, max_y: {:?}", start_v, max_y);
            return (true, max_y);
        }
        if pos.0 > t2.0 || pos.1 < t1.1 {
            return (false, max_y);
        }
        pos = add(pos, v);
        max_y = max_y.max(pos.1);
        v.0 -= v.0.signum();
        v.1 -= 1;
    }
}

fn parse(input: &[u8]) -> (Vec2, Vec2) {
    let cap = regex!(br".*x=([-0-9]+)..([-0-9]+).*")
        .match_slices(input)
        .unwrap();

    let x1 = utils::to_str(cap.0).parse().unwrap();
    let x2 = utils::to_str(cap.1).parse().unwrap();

    let cap = regex!(br".*y=([-0-9]+)..([-0-9]+).*")
        .match_slices(input)
        .unwrap();

    let y1 = utils::to_str(cap.0).parse().unwrap();
    let y2 = utils::to_str(cap.1).parse().unwrap();

    let t1 = (x1, y1);
    let t2 = (x2, y2);
    (t1, t2)
}

fn part1(t1: Vec2, t2: Vec2) -> Num {
    let top: Option<_> = (1..150)
        .flat_map(|x| (-200..200).map(move |y| (x, y)))
        .map(move |(x, y)| sim((x, y), t1, t2))
        .filter(|x| x.0)
        .map(|x| x.1)
        .max();
    top.unwrap_or(0)
}

fn part2(t1: Vec2, t2: Vec2) -> i16 {
    (1..150)
        .flat_map(|x| (-200..200).map(move |y| (x, y)))
        .map(move |(x, y)| sim((x, y), t1, t2))
        .filter(|x| x.0)
        .count() as i16
}

fn main() {
    let (t1, t2) = parse(include_bytes!("input.txt"));
    println!("{:?} {:?}", t1, t2);
    let r1 = part1(t1, t2);
    assert_eq!(r1, 15400);
    println!("part1: {:?}", r1);
    let r2 = part2(t1, t2);
    println!("part2: {:?}", r2);
    assert_eq!(r2, 5844);
}

#[test]
fn test1() {
    let (t1, t2) = parse("target area: x=20..30, y=-10..-5");
    assert_eq!(part1(t1, t2), 45);
    println!();
    assert_eq!(part2(t1, t2), 112);
}
