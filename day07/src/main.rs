#![no_std]
#![feature(start)]
io::entry!(main);

use staticvec::StaticVec;

type Number = i32;

fn parse(data: &str) -> StaticVec<i32, 2000> {
    data.split(',')
        .map(|v| v.parse::<i32>().unwrap())
        .collect::<StaticVec<_, 2000>>()
}

type CostFn = fn(k: Number) -> Number;

fn cost1(k: Number) -> Number {
    return k;
}

fn cost2(k: Number) -> Number {
    (1 + k) * k / 2
}

fn eval(data: &[i32], v: i32, cost: CostFn) -> i32 {
    if v & 1 == 0 {
        io::write(".")
    };
    data.iter()
        .map(|i| cost((i - v).abs()))
        .fold(0, |a, v| a + v)
}

fn find_min(data: &[i32], cost: CostFn) -> Number {
    let lo = *data.iter().min().unwrap();
    let hi = *data.iter().max().unwrap();
    io::write_int(lo);
    io::write(" ");
    io::write_int(hi);
    (lo..=hi).map(|v| eval(data, v, cost)).min().unwrap()
}

fn main() {
    let data = parse(include_str!("input.txt"));

    let min = find_min(&data, cost1);
    io::write("part1: ");
    io::write_int(min);
    io::writeln();

    let min = find_min(&data, cost2);
    io::write("part2: ");
    io::write_int(min);
    io::writeln();
}

#[cfg(test)]
mod tests {
    use super::*;

    const TEST_DATA: &str = include_str!("test_input.txt");

    #[test]
    fn test_eval1() {
        let data = parse(TEST_DATA);
        assert!(eval(&data, 2, cost1) == 37);
    }
    #[test]
    fn test_eval2() {
        let data = parse(TEST_DATA);
        assert!(eval(&data, 5, cost2) == 168);
    }
    #[test]
    fn test_cost1() {
        assert!(cost2(0) == 0);
        assert!(cost2(1) == 1);
        assert!(cost2(2) == 3);
        assert!(cost2(4) == 10);
    }
}
