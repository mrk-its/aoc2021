use lazy_static::lazy_static;
use regex::Regex;

#[derive(Debug, Clone, Copy)]
enum Fold {
    X(usize),
    Y(usize),
}

#[derive(Debug)]
struct Origami {
    paper: Vec<Vec<u8>>,
    folds: Vec<Fold>,
}

impl Origami {
    fn show(&self) {
        for line in &self.paper {
            println!("{}", String::from_iter(line.iter().map(|v| if *v == 0 {' '} else {'█'})));
        }
        println!("folds: {:?}", self.folds);
        println!();
    }
    fn fold_x(&mut self, value: usize) {
        let h = self.paper.len();
        let w = self.paper[0].len();
        for y in 0..h {
            for i in value + 1..w {
                self.paper[y][value - (i - value)] |= self.paper[y][i];
            }
            self.paper[y].truncate(value);
        }

    }
    fn fold_y(&mut self, value: usize) {
        let h = self.paper.len();
        let w = self.paper[0].len();
        for y in value + 1..h {
            for i in 0..w {
                self.paper[value - (y - value)][i] |= self.paper[y][i];
            }
        }
        self.paper.truncate(value);
    }
    fn fold(&mut self, fold: Fold) {
        match fold {
            Fold::X(value) => self.fold_x(value),
            Fold::Y(value) => self.fold_y(value),
        }
    }
    fn count_dots(&self) -> i32 {
        let mut cnt = 0;
        for row in &self.paper {
            for c in row {
                if *c > 0 {
                    cnt += 1;
                }
            }
        }
        cnt
    }
}

lazy_static! {
    static ref COORDS_RE: Regex = Regex::new(r"^(\d+),(\d+)").unwrap();
    static ref FOLD_RE: Regex = Regex::new(r"^fold along (.)=(\d+)").unwrap();
}

fn parse(input: &str) -> Origami {
    let mut paper = Vec::new();
    let mut folds = Vec::new();
    let lines = input.split('\n');

    let mut coords = Vec::new();


    for line in lines {
        println!("{}", line);
        if let Some(cap) = COORDS_RE.captures(line) {
            let vec = cap
                .iter()
                .skip(1)
                .map(|m| m.unwrap().as_str().parse::<usize>().unwrap())
                .collect::<Vec<_>>();
            coords.push(vec);
        } else if let Some(cap) = FOLD_RE.captures(line) {
            let dir = cap.get(1).unwrap().as_str();
            let value = cap.get(2).unwrap().as_str().parse().unwrap();
            folds.push(match dir {
                "x" => Fold::X(value),
                "y" => Fold::Y(value),
                _ => panic!(),
            });
        }
    }

    let max_x = coords.iter().map(|c| c[0]).max().unwrap() + 1;
    let max_y = coords.iter().map(|c| c[1]).max().unwrap() + 1;

    paper.resize_with(max_y, || {
        let mut vec = Vec::with_capacity(max_x);
        vec.resize(max_x, 0);
        vec
    });

    for coord in coords {
        paper[coord[1]][coord[0]] = 1;
    }

    Origami { paper, folds }
}

fn main() {
    let mut origami = parse(include_str!("input.txt"));
    origami.show();

    let mut part1 = 0;

    for (n, fold) in origami.folds.clone().iter().enumerate() {
        origami.fold(*fold);
        origami.show();
        if n == 0 {
            part1 = origami.count_dots();
        }
    }
    println!("part1: {}", part1);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test() {}
}
