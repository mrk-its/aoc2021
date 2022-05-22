#![no_std]
#![feature(start)]
#![feature(default_alloc_error_handler)]

utils::entry!(main);
extern crate alloc;
extern crate mos_alloc;

use alloc::vec::Vec;
use safe_regex::regex;
use ufmt_stdio::*;

#[derive(Eq, PartialEq, Clone, Copy)]
struct Pair(u8, u8);

impl utils::SimpleHash for Pair {
    fn hash(&self) -> usize {
        utils::hash::hash8(self.0, self.1) as usize
    }
}

type Defs = utils::SimpleMap<200, Pair, u8>;
type Template<'a> = &'a [u8];

type PairCounts = utils::SimpleMap<200, Pair, i64>;

fn parse<'a>(mut lines: impl Iterator<Item = &'a [u8]>) -> (Template<'a>, Defs) {
    #[allow(non_snake_case)]
    let RE = regex!(br"(..) -> (.)");
    let mut defs = Defs::new();
    let template = lines.next().unwrap();
    lines.next().unwrap();
    for line in lines {
        let (left, right) = RE.match_slices(line).unwrap();
        let pair = Pair(left[0], left[1]);
        let c = right[0];
        defs.insert(pair, c);
    }
    (template, defs)
}

fn inject(input: &PairCounts, defs: &Defs) -> PairCounts {
    let mut out = PairCounts::new();
    for (pair, cnt) in input.iter() {
        let c = defs.get(pair);
        match c {
            Some(&c) => {
                let pair_a = Pair(pair.0, c);
                let pair_b = Pair(c, pair.1);
                *out.entry(pair_a).or_default() += cnt;
                *out.entry(pair_b).or_default() += cnt;
            }
            None => *out.entry(*pair).or_default() += cnt,
        }
    }
    out
}

fn score(template: &Template, input: &PairCounts) -> i64 {
    let mut stats: utils::SimpleMap<200, u8, i64> = utils::SimpleMap::new();
    stats.insert(*template.first().unwrap(), 1);
    stats.insert(*template.last().unwrap(), 1);

    for (pair, cnt) in input.iter() {
        *stats.entry(pair.0).or_default() += cnt;
        *stats.entry(pair.1).or_default() += cnt;
    }

    let mut stats = stats
        .iter()
        .map(|(c, &cnt)| (c, cnt / 2))
        .collect::<Vec<_>>();
    stats.sort_by_key(|f| -f.1);
    stats.first().unwrap().1 - stats.last().unwrap().1
}

fn main() {
    let (template, defs) = parse(utils::iter_lines!("input.txt"));
    let mut pair_counts = PairCounts::new();
    for i in 0..template.len() - 1 {
        *pair_counts
            .entry(Pair(template[i], template[i + 1]))
            .or_default() += 1
    }
    let mut input = pair_counts;

    for i in 0..40 {
        if i == 10 {
            println!("part1: {:?}", score(&template, &input));
        }
        input = inject(&input, &defs);
    }
    println!("part2: {:?}", score(&template, &input));
}
