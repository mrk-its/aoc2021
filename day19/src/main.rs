use std::{collections::{HashSet, HashMap}};

use glam::{f32::{Affine3A, Mat3A}, IVec3, Vec3};
use itertools::Itertools;

fn parse_scanner(input: &str) -> Vec<IVec3> {
    let mut points = input
    .split('\n')
    .skip(1)
    .map(|line| {
        IVec3::from_slice(
            &line
                .split(',')
                .map(|v| v.parse::<i32>().unwrap())
                .collect::<Vec<_>>(),
        )
    })
    .collect::<Vec<_>>();
    points
}

fn generate_vectors(points: &[IVec3]) -> Vec<(IVec3, IVec3)> {
    let mut res = Vec::new();
    for (p0, p1) in combinations2(points) {
        res.push((*p0, *p1));
    }
    res 
}

fn length(v: &(IVec3, IVec3)) -> i32 {
    let v = v.0 - v.1;
    v.dot(v)
}

fn sort(pair: &(IVec3, IVec3)) -> (IVec3, IVec3) {
        if pair.0.gt(&pair.1) {
            (pair.1, pair.0)
        } else {
            (pair.0, pair.1)
        }
}

fn generate_lengths(points: &[IVec3]) -> HashSet<i32> {
    let mut res = HashSet::new();
    for (p0, p1) in combinations2(points) {
        let v = *p1 - *p0;
        res.insert(v.dot(v));
    }
    res
}

fn common_points(a: &[IVec3], b: &[IVec3]) -> (Vec<(IVec3, IVec3)>, Vec<(IVec3, IVec3)>) {
    let v1 = generate_vectors(a);
    let v2 = generate_vectors(b);
    
    let mut cnts1: HashMap<i32, usize> = HashMap::new();

    for v in &v1 {
        let len = length(&v);
        *cnts1.entry(len).or_default() += 1;
    }
    let mut cnts2: HashMap<i32, usize> = HashMap::new();

    for v in &v2 {
        let len = length(&v);
        *cnts2.entry(len).or_default() += 1;
    }

    let l1 = v1.iter().map(length).filter(|len| cnts1.get(len).unwrap() == &1).collect::<HashSet<_>>();
    let l2 = v2.iter().map(length).filter(|len| cnts2.get(len).unwrap() == &1).collect::<HashSet<_>>();

    let common_lengths = l1.intersection(&l2).collect::<HashSet<_>>();

    let mut v1 = v1.iter().map(sort).filter(|v| common_lengths.contains(&length(v))).collect::<Vec<_>>();
    let mut v2 = v2.iter().map(sort).filter(|v| common_lengths.contains(&length(v))).collect::<Vec<_>>();
    assert_eq!(v1.len(), common_lengths.len());
    assert_eq!(v2.len(), common_lengths.len());

    v1.sort_by_key(length);
    v2.sort_by_key(length);

    (v1, v2)
}


fn parse(input: &str) -> Vec<Vec<IVec3>> {
    input.split("\n\n").map(|scanner_data| parse_scanner(scanner_data)).collect()
}

fn combinations2<'a, T>(input: &'a [T]) -> Vec<(&'a T, &'a T)> where T: Clone {
    let mut out = Vec::new();
    for i in 0..input.len() {
        for j in i+1..input.len() {
            out.push((&input[i], &input[j]));
        }        
    };
    out
}

fn to_ivec3(input: Vec3) -> IVec3 {
    return IVec3::new(input.x.round() as i32, input.y.round() as i32, input.z.round() as i32)
}

fn rotations() -> Vec<Mat3A> {
    let mut out = Vec::new();
    let mut bases = Vec::new();
    for i in 0..4 {
        bases.push(Affine3A::from_rotation_y(std::f32::consts::PI / 2.0 * i as f32).matrix3);
    };
    bases.push(Affine3A::from_rotation_x(std::f32::consts::PI / 2.0).matrix3);
    bases.push(Affine3A::from_rotation_x(-std::f32::consts::PI / 2.0).matrix3);

    for base in bases {
        for rot in 0..4 {
            out.push(base * Affine3A::from_rotation_z(std::f32::consts::PI / 2.0 * rot as f32).matrix3);
        }    
    }   
    out
}

fn comb2(n: usize) -> Vec<(usize, usize)> {
    let mut out = Vec::new();
    for i in 0..n {
        for j in i+1..n {
            out.push((i, j));
        }
    }
    out
}

fn main() {
    let scanners = parse(include_str!("input.txt"));
    let v = IVec3::new(1, 2, 3);
    let mut out = HashSet::new();
    for rot in rotations() {
        out.insert(to_ivec3(rot * v.as_vec3()));
    }
    let rotations = rotations();

    let mut scanners = scanners.iter().cloned().enumerate().collect::<HashMap<_, _>>(); 

    let mut offsets = HashSet::new();
    offsets.insert(IVec3::new(0,0,0));

    let mut pairs = comb2(scanners.len());

    let mut processed = HashSet::new();
    processed.insert(0usize);

    while !pairs.is_empty() {
        let (index, _) = pairs.iter().enumerate().filter(|(index, pair)| processed.contains(&pair.0) || processed.contains(&pair.1)).next().unwrap();
        let (a, b)  = pairs.remove(index);

        let (a, b) = if processed.contains(&a) {
            (a, b)
        } else {
            (b, a)
        };

        let (c1, c2) = common_points(scanners.get(&a).unwrap(), scanners.get(&b).unwrap());
        if c1.len() < 60 {
            continue
        }

        for rot in &rotations {
            let rotated = c2.iter().map(|(p1, p2)| sort(&(to_ivec3(*rot * p1.as_vec3()), to_ivec3(*rot * p2.as_vec3())))).collect::<Vec<_>>();
            let out = c1.iter().zip(rotated).map(|(a, b)| (a.0 - b.0)).collect::<HashSet<_>>();
            // println!("{:?} {:?}", to_ivec3(rot * c2[0].0.as_vec3()) - c1[0].0,  to_ivec3(rot * c2[0].1.as_vec3()) - c1[0].1);
            if out.len() == 1 {
                println!("{:?}-{:?} - {:?}", a, b, out);
                let offs = out.iter().next().unwrap();
                offsets.insert(*offs);
                let rotated = scanners.get(&b).unwrap().iter().map(|v| to_ivec3(*rot * v.as_vec3()) + *offs).collect::<Vec<_>>();
                scanners.insert(b, rotated);
            }
        }

        processed.insert(a);
        processed.insert(b);

    };

    let mut becons = HashSet::new();

    for scanner in &scanners {
        for b in scanner.1 {
            becons.insert(*b);
        }
    }

    let mut max=0;
    for b1 in &offsets {
        for b2 in &offsets {
            let p = (*b1 - *b2).abs();
            max = max.max(p.x + p.y + p.z);
        }
    }

    println!("part1: {:?}", becons.len());
    println!("part2: {}", max);
}

#[test]
fn test_parse1() {}
