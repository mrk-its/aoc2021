#![no_std]
#![feature(start)]
io::entry!(main);

fn main() {
    let mut pos = 0;
    let mut depth = 0;
    io::write("start!\n");
    let parsed = include_str!("input.txt").split('\n').map(|line| {
        let mut p = line.split(' ');
        let dir = p.next().unwrap();
        let n = p.next().unwrap();
        (dir, n.parse::<u8>().unwrap())
    });

    // string pattern matching doesn't work!
    //

    for (dir, n) in parsed.clone() {
        let n = n as i32;
        match dir {
            "forward" => pos += n,
            "down" => depth += n,
            "up" => depth -= n,
            _ => panic!(),
        }
    }
    io::write("part1: ");
    io::write_int(pos * depth);
    io::writeln();

    let mut pos = 0;
    let mut depth = 0;
    let mut aim = 0;

    for (dir, n) in parsed.clone() {
        let n = n as u32;
        match dir {
            "forward" => {
                pos += n;
                depth += aim * n;
            }
            "down" => aim += n,
            "up" => aim -= n,
            _ => panic!(),
        }
    }
    io::write("part2: ");
    io::write_int(pos * depth);
    io::writeln();
}
