use std::collections::HashMap;
type Pair = (char, char);
type Defs = HashMap<Pair, char>;
type Template = Vec<char>;

type PairCounts = HashMap<Pair, i64>;

fn parse<'a>(input: &'a str) -> (Template, Defs) {
    let mut defs = Defs::new();
    let mut splitted = input.split("\n\n");
    let template = splitted.next().unwrap().chars().collect();
    let defs_text = splitted.next().unwrap();
    for def in defs_text.split("\n") {
        let mut splitted = def.split(" -> ");
        let mut left_text = splitted.next().unwrap().chars();
        let pair = (left_text.next().unwrap(), left_text.next().unwrap());
        let c = splitted.next().unwrap().chars().next().unwrap();
        defs.insert(pair, c);
    }
    (template, defs)
}

fn inject(input: &PairCounts, defs: &Defs) -> PairCounts {
    let mut out = PairCounts::new();
    for (pair, cnt) in input {
        let c = defs.get(pair);
        match c {
            Some(&c) => {
                let pair_a = (pair.0, c);
                let pair_b = (c, pair.1);
                *out.entry(pair_a).or_default() += cnt;
                *out.entry(pair_b).or_default() += cnt;
            }
            None => *out.entry(*pair).or_default() += cnt,
        }
    }
    out
}

fn score(template: &Template, input: &PairCounts) -> i64 {
    let mut stats: HashMap<char, i64> = HashMap::new();
    stats.insert(*template.first().unwrap(), 1);
    stats.insert(*template.last().unwrap(), 1);


    for (pair, cnt) in input {
        *stats.entry(pair.0).or_default() += cnt;
        *stats.entry(pair.1).or_default() += cnt;
    }

    let mut stats = stats.iter().map(|(&c, &cnt)| (c, cnt / 2)).collect::<Vec<_>>();
    stats.sort_by_key(|f| -f.1);
    stats.first().unwrap().1 - stats.last().unwrap().1
}

fn main() {
    let (template, defs) = parse(include_str!("input.txt"));
    let mut pair_counts = PairCounts::new();
    for i in 0..template.len() - 1 {
        *pair_counts.entry((template[i], template[i+1])).or_default() += 1
    }
    let mut input = pair_counts.clone();

    for i in 0..40 {
        if i == 10 {
            println!("part1: {:?}", score(&template, &input));
        }
        input = inject(&input, &defs);
    }
    println!("part2: {:?}", score(&template, &input));
}
