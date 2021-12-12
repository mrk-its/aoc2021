use itertools::Itertools;
use std::{collections::{HashSet, HashMap}, time::Duration};

type Graph<'a> = HashMap<&'a str, Vec<&'a str>>;


fn parse_graph<'a>(input: &'a str) -> Graph<'a> {
    let mut graph: Graph = HashMap::new();
    let lines = input
        .split('\n');

    for line in lines {
        let mut x = line.split('-');
        let node_a = x.next().unwrap();
        let node_b = x.next().unwrap();
        graph.entry(node_a).or_default().push(node_b);
        graph.entry(node_b).or_default().push(node_a);
    }

    graph

}

fn is_uppercase(text: &str) -> bool {
    text.chars().all(|c| c.is_uppercase())
}

fn checker1(node: &str, visited: &Vec<&str>) -> bool {
    if is_uppercase(node) {
        return true;
    }
    let mut counts: HashMap<&str, i32> = HashMap::new();
    for n in visited {
        if is_uppercase(n) {
            continue;
        }
        let x = counts.entry(n).or_default();
        *x += 1;
    }
    let cnts = counts.values().collect::<Vec<_>>();
    return !cnts.contains(&&2)
}

fn checker2(node: &str, visited: &Vec<&str>) -> bool {
    if is_uppercase(node) {
        return true;
    }
    let mut counts: HashMap<&str, i32> = HashMap::new();
    for n in visited {
        if is_uppercase(n) {
            continue;
        }
        let x = counts.entry(n).or_default();
        *x += 1;
    }
    let cnts = counts.values().cloned().collect::<Vec<_>>();

    cnts.iter().all(|c| *c < 2) || cnts.iter().cloned().filter(|&c| c==2).count() == 1
}

fn visit_dfs<'a>(graph: &'a Graph, start: &'a str, mut visited: Vec<&'a str>, paths: &mut Vec<Vec<&'a str>>, valid: fn(node: &str, visited: &Vec<&str>) -> bool) {
    if start == "end" {
        paths.push(visited.clone());
        return;
    }
    visited.push(start);
    if !valid(start, &visited) {
        return
    }
    let nodes = graph.get(start).unwrap();
    for &dest in nodes {
        if dest == "start" {
            continue;
        }
        visit_dfs(graph, dest, visited.clone(), paths, valid);
    }
}


fn main() {
    let graph = parse_graph(include_str!("input.txt"));
    println!("graph: {:?}", graph);
    let mut paths = Vec::new();
    visit_dfs(&graph, "start", Vec::new(), &mut paths, checker1);
    println!("part1: {}", paths.len());

    let mut paths = Vec::new();
    visit_dfs(&graph, "start", Vec::new(), &mut paths, checker2);
    println!("part2: {}", paths.len());


}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test() {
    }
}
