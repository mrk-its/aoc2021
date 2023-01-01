#![no_std]
#![feature(start)]

utils::entry!(main);
extern crate alloc;
extern crate mos_alloc;

use alloc::vec::Vec;
use ufmt_stdio::*;
use utils::SimpleMap;

type Graph<'a> = SimpleMap<100, &'a [u8], Vec<&'a [u8]>>;

fn parse_graph<'a>(lines: impl Iterator<Item = &'a [u8]>) -> Graph<'a> {
    let mut graph = Graph::new();

    for line in lines {
        let mut x = line.split(|f| *f == b'-');
        let node_a = x.next().unwrap();
        let node_b = x.next().unwrap();

        graph.entry(node_a).or_default().push(node_b);
        graph.entry(node_b).or_default().push(node_a);
    }

    graph
}

fn is_uppercase(text: &[u8]) -> bool {
    text.iter().all(|c| *c & 0x20 == 0)
}

fn checker1(node: &[u8], visited: &Vec<&[u8]>) -> bool {
    if is_uppercase(node) {
        return true;
    }
    let mut counts: SimpleMap<30, &[u8], i32> = SimpleMap::new();
    for n in visited {
        if is_uppercase(n) {
            continue;
        }
        let v = match counts.get(n) {
            Some(v) => *v + 1,
            None => 1,
        };
        counts.insert(n, v);
    }
    let mut vals = counts.values();
    !vals.any(|v| *v == 2)
}

fn checker2(node: &[u8], visited: &Vec<&[u8]>) -> bool {
    if is_uppercase(node) {
        return true;
    }
    let mut counts: SimpleMap<30, &[u8], i32> = SimpleMap::new();
    for n in visited {
        if is_uppercase(n) {
            continue;
        }
        let v = match counts.get(n) {
            Some(v) => *v + 1,
            None => 1,
        };
        counts.insert(n, v);
    }
    let mut cnts = counts.values();
    if cnts.all(|c| *c < 2) {
        return true;
    }
    let cnts = counts.values();
    cnts.filter(|&c| *c == 2).count() == 1
}

fn visit_dfs<'a>(
    graph: &'a Graph,
    start: &'a [u8],
    mut visited: Vec<&'a [u8]>,
    n_paths: &mut u32,
    valid: fn(node: &[u8], visited: &Vec<&[u8]>) -> bool,
    depth: usize,
) {
    if start == b"end" {
        *n_paths += 1;
        // if *n_paths & 0xff == 0 {
        //     println!("n_paths: {}, free: {}", *n_paths, mos_alloc::bytes_free());
        // }
        return;
    }
    visited.push(start);
    if !valid(start, &visited) {
        return;
    }
    let nodes = graph.get(&start).unwrap();
    for &dest in nodes {
        if dest == b"start" {
            continue;
        }
        visit_dfs(graph, dest, visited.clone(), n_paths, valid, depth + 1);
    }
}

fn main() {
    let graph = parse_graph(utils::iter_lines!("input.txt"));
    println!("parsed!");
    let mut n_paths = 0;
    visit_dfs(&graph, b"start", Vec::new(), &mut n_paths, checker1, 0);
    println!("part1: {}", n_paths);
    assert!(n_paths == 4167);
    let mut n_paths = 0;
    visit_dfs(&graph, b"start", Vec::new(), &mut n_paths, checker2, 0);
    println!("part2: {}", n_paths);
    assert!(n_paths == 98441);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test() {}
}
