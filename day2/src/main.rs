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

        println!("dir: {} n: {}, pos: {}, depth: {}", dir, n, pos, depth);
    }
    println!("result: {}", pos * depth);
}
