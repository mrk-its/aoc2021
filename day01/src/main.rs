#![no_std]
#![feature(start)]
io::entry!(main);

use staticvec::StaticVec;

fn main() {
    let input = include_str!("input.txt");

    // let regex = safe_regex::regex!(b".*");

    io::write("parsing...");
    let parsed = input
        .split('\n')
        .map(|i| i.parse::<i16>().unwrap())
        .collect::<StaticVec<i16, 2000>>();
    io::write("done\n");

    let part1 = parsed
        .iter()
        .zip(&parsed[1..])
        .filter(|(a, b)| a < b)
        .count();

    io::write("part1: ");
    io::write_int(part1 as i16);
    io::write("\n");

    let values = parsed
        .iter()
        .zip(&parsed[1..])
        .zip(&parsed[2..])
        .map(|((a, b), c)| a + b + c);
    let part2 = values
        .clone()
        .zip(values.skip(1))
        .filter(|(a, b)| b > a)
        .count();
    io::write("part2: ");
    io::write_int(part2 as i16);
    io::write("\n");
}
