use regex::Regex;
type Vec2 = (i32, i32);

fn add(a: Vec2, b: Vec2) -> Vec2 {
    (a.0 + b.0, a.1 + b.1)
}

fn in_target(pos: Vec2, t1: Vec2, t2: Vec2) -> bool {
    pos.0 >= t1.0 && pos.0 <= t2.0 && pos.1 >= t1.1 && pos.1 <= t2.1
}

fn sim(start_v: Vec2, t1: Vec2, t2: Vec2) -> (bool, i32) {
    let mut v = start_v;
    let mut pos = (0, 0);
    let mut max_y = pos.1;
    loop {
        if in_target(pos, t1, t2) {
            println!("start_v: {:?}, max_y: {:?}", start_v, max_y);
            return (true, max_y);
        }
        if pos.0 > t2.0 || pos.1 < t1.1 {
            return (false, max_y);
        }
        pos = add(pos, v);
        max_y = max_y.max(pos.1);
        v.0 -= v.0.signum();
        v.1 -= 1;
    }
}

fn parse(input: &str) -> (Vec2, Vec2) {
    let re = Regex::new(r"target area: x=([\d-]+)..([\d-]+), y=([\d-]+)..([\d-]+)").unwrap();

    let cap = re.captures(input).unwrap();
    let x1: i32 = cap.get(1).unwrap().as_str().parse().unwrap();
    let x2: i32 = cap.get(2).unwrap().as_str().parse().unwrap();
    let y1: i32 = cap.get(3).unwrap().as_str().parse().unwrap();
    let y2: i32 = cap.get(4).unwrap().as_str().parse().unwrap();

    let t1 = (x1, y1);
    let t2 = (x2, y2);
    (t1, t2)
}

fn part1(t1: Vec2, t2: Vec2) -> i32 {
    let top: Option<i32> = (0..20)
        .flat_map(|x| (0..100).map(move |y| (x, y)))
        .map(move |(x, y)| sim((x, y), t1, t2))
        .filter(|x| x.0).map(|x| x.1).max();
    top.unwrap_or(0)
}

fn part2(t1: Vec2, t2: Vec2) -> i32 {
    (1..150)
        .flat_map(|x| (-500..5000).map(move |y| (x, y)))
        .map(move |(x, y)| sim((x, y), t1, t2))
        .filter(|x| x.0).count() as i32
}

fn main() {
    let (t1, t2) = parse(include_str!("input.txt"));
    println!("{:?} {:?}", t1, t2);
    println!("part1: {:?}", part1(t1, t2));
    println!("part2: {:?}", part2(t1, t2));
    // println!("ret: {:?}", ret);
}

#[test]
fn test1() {
    let (t1, t2) = parse("target area: x=20..30, y=-10..-5");
    assert_eq!(part1(t1, t2), 45);
    println!();
    assert_eq!(part2(t1, t2), 112);

}
