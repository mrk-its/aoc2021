use itertools::{GroupBy, Itertools};
use std::collections::{HashMap, HashSet};

type Display = HashSet<char>;

fn parse_display(input: &str) -> Display {
    input.chars().collect::<Display>()
}

fn parse_displays(input: &str) -> Vec<Display> {
    input
        .split(' ')
        .map(parse_display)
        .collect::<Vec<Display>>()
}

fn parse_line(line: &str) -> (Vec<Display>, Vec<Display>) {
    let mut parts = line.split(" | ");
    let left = parts.next().unwrap();
    let right = parts.next().unwrap();
    (parse_displays(left), parse_displays(right))
}

fn parse(input: &str) -> Vec<(Vec<Display>, Vec<Display>)> {
    input
        .split('\n')
        .map(parse_line)
        .collect::<Vec<(Vec<Display>, Vec<Display>)>>()
}

fn decode(input: &Vec<Display>, out: &Vec<Display>) -> u32 {
    let mut input = input.clone();
    input.sort_by_key(|f| f.len());
    let x = input.iter().group_by(|k| k.len());
    let by_len = x
        .into_iter()
        .map(|(cnt, group)| (cnt, group.collect::<Vec<_>>()))
        .collect::<HashMap<usize, Vec<_>>>();

    let d1: &Display = by_len.get(&2).unwrap()[0];
    let d4: &Display = by_len.get(&4).unwrap()[0];
    let d8: &Display = by_len.get(&7).unwrap()[0];
    let d7: &Display = by_len.get(&3).unwrap()[0];
    let d3 = *by_len
        .get(&5)
        .and_then(|items| {
            items
                .iter()
                .filter(|c| c.intersection(&d1).count() == 2)
                .next()
        })
        .unwrap();
    let d6 = *by_len
        .get(&6)
        .and_then(|items| {
            items
                .iter()
                .filter(|c| c.intersection(&d1).count() == 1)
                .next()
        })
        .unwrap();

    let top_right = *d8.difference(d6).next().unwrap();

    let d2 = *by_len
        .get(&5)
        .and_then(|items| {
            items
                .iter()
                .filter(|c| **c != d3 && c.contains(&top_right))
                .next()
        })
        .unwrap();
    let d5 = *by_len
        .get(&5)
        .and_then(|f| {
            f.iter()
                .filter(|c| **c != d3 && !c.contains(&top_right))
                .next()
        })
        .unwrap();

    let d9 = *by_len
        .get(&6)
        .and_then(|f| {
            f.iter()
                .filter(|c| c.intersection(d3).count() == d3.len())
                .next()
        })
        .unwrap();

    let d0 = *by_len
        .get(&6)
        .and_then(|f| f.iter().filter(|c| **c != d9 && **c != d6).next())
        .unwrap();

    let digits = [d0, d1, d2, d3, d4, d5, d6, d7, d8, d9];

    let out = out
        .iter()
        .flat_map(|c| {
            digits
                .iter()
                .enumerate()
                .filter(|(pos, x)| ***x == *c)
                .next()
        })
        .map(|v| v.0)
        .collect::<Vec<usize>>();
    let out = out
        .iter()
        .enumerate()
        .map(|c| *c.1 as u32 * 10u32.pow(3 - c.0 as u32))
        .collect::<Vec<_>>();
    out.iter().fold(0, |a, v| a + v)
}

fn main() {
    let data = parse(include_str!("input.txt"));
    let mut cnt = 0;

    let lengths = [2, 4, 3, 7];
    for (_, out) in &data {
        cnt += out.iter().filter(|c| lengths.contains(&c.len())).count();
    }
    println!("part1: {:?}", cnt);

    for (input, out) in &data {
        cnt += out.iter().filter(|c| lengths.contains(&c.len())).count();
    }

    let mut sum = 0;
    for (input, out) in &data {
        sum += decode(input, out);
    }
    println!("part2: {:?}", sum);
}

#[cfg(test)]
mod tests {
    use super::*;

    const TEST_DATA: &str =
        "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf";

    #[test]
    fn test1() {
        let data = parse(TEST_DATA);

        let (input, out) = &data[0];
        assert!(decode(&input, &out) == 5353);
    }
}
