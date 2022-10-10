#![no_std]
#![feature(start)]
#![feature(default_alloc_error_handler)]

utils::entry!(main);
extern crate alloc;
extern crate mos_alloc;

use alloc::vec::Vec;
use safe_regex::regex;
use ufmt::derive::uDebug;
use ufmt_stdio::*;

#[derive(Debug, Clone, Copy)]
enum Fold {
    X(i16),
    Y(i16),
}

#[derive(Copy, Clone, PartialEq, Eq, uDebug)]
struct Point(i16, i16);

impl utils::SimpleHash for Point {
    fn hash(&self) -> usize {
        ((self.0 << 3) ^ self.1) as usize
    }
}

type Paper = utils::SimpleSet<1000, Point>;

struct Origami {
    paper: Paper,
    folds: Vec<Fold>,
}

fn do_fold(paper: &Paper, fold: &Fold) -> Paper {
    let mut dest = Paper::new();
    for point in paper.iter() {
        let p = match fold {
            Fold::X(k) => {
                if point.0 > *k {
                    Point(*k - (point.0 - *k), point.1)
                } else {
                    *point
                }
            }
            Fold::Y(k) => {
                if point.1 > *k {
                    Point(point.0, *k - (point.1 - *k))
                } else {
                    *point
                }
            }
        };
        dest.insert(p);
    }
    dest
}

fn show(paper: &Paper) {
    let (size_x, size_y) = paper
        .iter()
        .fold((0, 0), |a, b| (a.0.max(b.0), a.1.max(b.1)));
    for y in 0..=size_y {
        for x in 0..=size_x {
            let c = if paper.contains(&Point(x, y)) {
                "#"
            } else {
                " "
            };
            print!("{}", c);
        }
        println!();
    }
}

fn parse<'a>(lines: impl Iterator<Item = &'a [u8]>) -> Origami {
    #[allow(non_snake_case)]
    let COORDS_RE = regex!(br"([0-9]+),([0-9]+)");
    #[allow(non_snake_case)]
    let FOLD_RE = regex!(br"fold along (.)=([0-9]+)");

    let mut folds = Vec::new();

    let mut paper: utils::SimpleSet<1000, Point> = utils::SimpleSet::new();

    for line in lines {
        // println!("line: {:?}", line);
        if let Some((x, y)) = COORDS_RE.match_slices(line) {
            // println!("coords: {:?} {:?}", x, y);
            let x = utils::to_str(x).parse().unwrap();
            let y = utils::to_str(y).parse().unwrap();
            paper.insert(Point(x, y));
        } else if let Some((dir, value)) = FOLD_RE.match_slices(line) {
            // println!("dir: {:?} value: {:?}", dir, value);
            let value = utils::to_str(value).parse().unwrap();
            folds.push(match dir {
                b"x" => Fold::X(value),
                b"y" => Fold::Y(value),
                _ => panic!(),
            });
        }
    }

    Origami { paper, folds }
}

fn main() {
    let origami = parse(utils::iter_lines!("input.txt"));
    println!("parsed");

    let mut part1 = 0;

    let mut paper = origami.paper;
    for (n, fold) in origami.folds.iter().enumerate() {
        paper = do_fold(&mut paper, fold);
        if n == 0 {
            part1 = paper.iter().count();
        }
    }
    println!("part1: {}", part1);
    assert!(part1 == 669);
    let part2 = paper.iter().count();
    println!("part2: {}", part2);
    show(&paper);
    assert!(part2 == 90);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test() {}
}
