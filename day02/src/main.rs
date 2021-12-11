fn main() {
    let mut pos = 0;
    let mut depth = 0;
    for line in include_str!("input.txt").split("\n") {
        let (dir, n) = line.split_once(" ").unwrap();
        let n: i32 = n.parse().unwrap();

        match dir {
            "forward" => pos += n,
            "down" => depth += n,
            "up" => depth -= n,
            _ => panic!("impossible!")
        }
    }
    println!("part1: {}", pos * depth);

    let mut pos = 0;
    let mut depth = 0;
    let mut aim = 0;

    let input = include_str!("input.txt");

    for line in input.split("\n") {
        let (dir, n) = line.split_once(" ").unwrap();
        let n: i32 = n.parse().unwrap();

        match dir {
            "forward" => {pos += n; depth += aim * n;}
            "down" => aim += n,
            "up" => aim -= n,
            _ => panic!("impossible!")
        }
    }
    println!("part2: {}", pos * depth);

}
