#[allow(unused_imports)]
use itertools::{Itertools};

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
struct Point(i64, i64, i64);
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
struct Cube(Point, Point);

fn overlaps(a: (i64, i64), b: (i64, i64)) -> bool {
    !(a.1 <= b.0 || a.0 >= b.1)
}

fn contains(a: (i64, i64), b: (i64, i64)) -> bool {
    b.0 >= a.0 && b.1 <= a.1
}

impl Cube {
    fn contains_cube(&self, c: &Cube) -> bool {
        contains((self.0 .0, self.1 .0), (c.0 .0, c.1 .0))
            && contains((self.0 .1, self.1 .1), (c.0 .1, c.1 .1))
            && contains((self.0 .2, self.1 .2), (c.0 .2, c.1 .2))
    }
    fn overlaps(&self, c: &Cube) -> bool {
        overlaps((self.0 .0, self.1 .0), (c.0 .0, c.1 .0))
            && overlaps((self.0 .1, self.1 .1), (c.0 .1, c.1 .1))
            && overlaps((self.0 .2, self.1 .2), (c.0 .2, c.1 .2))
    }

    fn split_x(&self, x: i64) -> Vec<Cube> {
        if x > self.0 .0 && x < self.1 .0 {
            let c1 = Cube(self.0, Point(x, self.1 .1, self.1 .2));
            let c2 = Cube(Point(x, self.0 .1, self.0 .2), self.1);
            vec![c1, c2]
        } else {
            vec![*self]
        }
    }
    fn split_y(&self, y: i64) -> Vec<Cube> {
        if y > self.0 .1 && y < self.1 .1 {
            let c1 = Cube(self.0, Point(self.1 .0, y, self.1 .2));
            let c2 = Cube(Point(self.0 .0, y, self.0 .2), self.1);
            vec![c1, c2]
        } else {
            vec![*self]
        }
    }
    fn split_z(&self, z: i64) -> Vec<Cube> {
        if z > self.0 .2 && z < self.1 .2 {
            let c1 = Cube(self.0, Point(self.1 .0, self.1 .1, z));
            let c2 = Cube(Point(self.0 .0, self.0 .1, z), self.1);
            vec![c1, c2]
        } else {
            vec![*self]
        }
    }
    fn split(&self, p: &Point) -> Vec<Cube> {
        let mut out = vec![];
        for px in self.split_x(p.0) {
            for py in px.split_y(p.1) {
                for pz in py.split_z(p.2) {
                    out.push(pz);
                }
            }
        }
        out
    }
    fn split2(&self, p1: &Point, p2: &Point) -> Vec<Cube> {
        self.split(p1).iter().flat_map(|c| c.split(p2)).collect()
    }
    // fn split_by(&self, points: &[Point]) -> Vec<Cube> {
    //     let mut result = vec![*self];
    //     for p in points {
    //         let mut new_result = vec![];
    //         for r in result {
    //             new_result.append(&mut r.split(p));
    //         }
    //         result = new_result;
    //     }
    //     // println!("result: {:?}", result);
    //     result.iter().collect::<HashSet<_>>().iter().cloned().cloned().collect()
    // }

    fn volume(&self) -> i64 {
        (self.1 .0 - self.0 .0) * (self.1 .1 - self.0 .1) * (self.1 .2 - self.0 .2)
    }

    fn sub(&self, c: &Cube) -> Vec<Cube> {
        if c.contains_cube(self) {
            vec![]
        } else if self.overlaps(c) {
            self.split2(&c.0, &c.1)
                .iter()
                .filter(|&part| !c.contains_cube(part))
                .cloned()
                .collect()
        } else {
            vec![*self]
        }
    }
}

fn parse(input: &str) -> Vec<(bool, Cube)> {
    let re = regex::Regex::new(
        r"(on|off) x=([\d-]+)..([\d-]+),y=([\d-]+)..([\d-]+),z=([\d-]+)..([\d-]+)",
    )
    .unwrap();

    input
        .split('\n')
        .map(|line| {
            let cap = re.captures(line).unwrap();
            let x1: i64 = cap.get(2).unwrap().as_str().parse().unwrap();
            let x2: i64 = cap.get(3).unwrap().as_str().parse().unwrap();
            let y1: i64 = cap.get(4).unwrap().as_str().parse().unwrap();
            let y2: i64 = cap.get(5).unwrap().as_str().parse().unwrap();
            let z1: i64 = cap.get(6).unwrap().as_str().parse().unwrap();
            let z2: i64 = cap.get(7).unwrap().as_str().parse().unwrap();
            let is_on = cap.get(1).unwrap().as_str() == "on";
            let cube = Cube(Point(x1, y1, z1), Point(x2 + 1, y2 + 1, z2 + 1));
            (is_on, cube)
        })
        .collect()
}

fn main() {
    let small_cube = Cube(Point(-50, -50, -50), Point(51, 51, 51));
    let cubes = parse(include_str!("input.txt"));
    for part in 1..=2 {
        let mut world: Vec<Cube> = vec![];
        let filtered = if part == 1 {
            cubes.iter().filter(|(_, c)| small_cube.contains_cube(c)).cloned().collect()
        } else {
            cubes.clone()
        };
        let total = filtered.len();
        for (k, (is_on, cube)) in filtered.iter().enumerate() {
            if part == 1 && !small_cube.contains_cube(cube) {
                continue
            }
            if *is_on {
                let mut cube_parts = vec![cube.clone()];
                for w in &world {
                    if w.overlaps(cube) {
                        let mut new_cube_parts = vec![];
                        for c in &cube_parts {
                            // let's subtract whole world from current cube
                            // and simply append it
                            new_cube_parts.append(&mut c.sub(w));
                        }
                        cube_parts = new_cube_parts;
                    }
                }
                world.append(&mut cube_parts);
    
            } else {
                let mut new_world = vec![];
                for w in &world {
                    new_world.append(&mut w.sub(cube));
                }
                world = new_world;
            };
            print!("{} / {}, len: {:?}\r", k + 1, total, world.len());
        }
        println!("\npart{}: {}", part, world.iter().map(|c| c.volume()).sum::<i64>())            
    }
}

#[test]
fn test_split() {
    let c = Cube(Point(0, 0, 0), Point(3, 3, 3));
    assert_eq!(c.volume(), 27);

    let parts = c.split_x(10);
    assert_eq!(parts.len(), 1);
    assert_eq!(parts[0].volume(), 27);

    let parts = c.split_x(2);
    assert_eq!(parts.len(), 2);
    assert_eq!(parts[0].volume(), 18);
    assert_eq!(parts[1].volume(), 9);

    let parts = c.split(&Point(2, 2, 2));
    assert_eq!(parts.len(), 8);

    let sum: i64 = parts.iter().map(|c| c.volume()).sum();
    assert_eq!(sum, 27);

    for v in parts.iter().combinations(2) {
        assert!(!v[0].overlaps(v[1]));
    }

    let parts = c.split2(&Point(1, 1, 1), &Point(2, 2, 2));
    let sum: i64 = parts.iter().map(|c| c.volume()).sum();
    assert_eq!(sum, 27);
    for v in parts.iter().combinations(2) {
        assert!(!v[0].overlaps(v[1]));
    }
}

#[test]
fn test_sub() {
    let c1 = Cube(Point(0, 0, 0), Point(2, 2, 2));
    let c2 = Cube(Point(1, 1, 1), Point(3, 3, 3));
    let result = c1.sub(&c2);
    assert_eq!(result.len(), 7);
}

#[test]
fn test_sub2() {
    let c1 = Cube(Point(0, 0, 0), Point(3, 3, 3));
    let c2 = Cube(Point(1, 1, 1), Point(2, 2, 2));
    let result = c1.sub(&c2);
    let sum: i64 = result.iter().map(|c| c.volume()).sum();
    assert_eq!(sum, 26);
}

#[test]
fn test_overlaps() {
    assert!(overlaps((0, 2), (1, 3)));
    assert!(overlaps((1, 3), (0, 2)));

    assert!(!overlaps((0, 2), (2, 4)));
    assert!(!overlaps((0, 2), (2, 4)));

    assert!(!overlaps((0, 2), (3, 4)));
    assert!(!overlaps((3, 4), (0, 2)));
}

#[test]
fn test_bug() {
    let c1 = Cube(Point(0, 2, 2), Point(6, 6, 8));
    let c2 = Cube(Point(2, 0, 0), Point(4, 4, 4));
    assert!(c1.overlaps(&c2));
    assert_eq!(c1.sub(&c2).len(), 11);
}