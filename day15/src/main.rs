// 6502: too big data (we need to store distance for each coord, so 250000 ints in part2)

use std::collections::{BinaryHeap, HashMap};
type Board = Vec<Vec<i32>>;
type Pos = (usize, usize);

fn neighbours(x: usize, y: usize, w: usize, h: usize) -> Vec<Pos> {
    let mut out = Vec::new();
    if y > 0 && x > 0 {
        out.push((x - 1, y - 1));
    }
    if x > 0 {
        out.push((x - 1, y));
    }
    if x < w - 1 {
        out.push((x + 1, y));
    }
    if y < h - 1 {
        out.push((x, y + 1));
    }
    out
}

fn parse(input: &str) -> Board {
    input
        .split("\n")
        .map(|r| r.bytes().map(|b| (b - 48) as i32).collect())
        .collect()
}

fn enlarge(board: &Board) -> Board {
    let h = board.len();
    let w = board[0].len();
    let mut out = Board::new();
    for y in 0..h * 5 {
        let mut row = Vec::new();
        for x in 0..w * 5 {
            let tile_x = x / w;
            let tile_y = y / h;
            let x = x % w;
            let y = y % h;
            let v = board[y][x];
            row.push(((v + tile_x as i32 + tile_y as i32) - 1) % 9 + 1);
        }
        out.push(row);
    }
    out
}

const MAX_DIST: i32 = i32::MAX;

fn route(board: &Board, pos: Pos, dest: Pos, max_distance: &mut usize) -> i32 {
    let h = board.len();
    let w = board[0].len();
    let mut queue: BinaryHeap<(i32, Pos)> = BinaryHeap::new();

    queue.push((0, pos));
    let mut distance: HashMap<Pos, i32> = HashMap::new();
    distance.insert(pos, 0);

    while !queue.is_empty() {
        let (_, u) = queue.pop().unwrap();
        if u == dest {
            return *distance.get(&u).unwrap();
        }
        for v in neighbours(u.0, u.1, w, h) {
            let alt = distance.get(&u).unwrap_or(&MAX_DIST) + board[v.1][v.0];
            if alt < *distance.get(&v).unwrap_or(&MAX_DIST) {
                distance.insert(v, alt);
                queue.push((-alt, v));
            }
        }
        *max_distance = (*max_distance).max(distance.len());
    }
    0
}

fn main() {
    let board = parse(include_str!("input.txt"));
    let h = board.len();
    let w = board[0].len();

    let mut max_distance = 0;

    let dist = route(&board, (0, 0), (w - 1, h - 1), &mut max_distance);
    println!("part1: {}, {}", dist, max_distance);
    let large = enlarge(&board);

    let mut max_distance = 0;
    let dist = route(&large, (0, 0), (w * 5 - 1, h * 5 - 1), &mut max_distance);
    println!("part2: {:?}, {}", dist, max_distance);
}

#[test]
fn test_neighbours_1() {
    assert_eq!(neighbours(1, 1, 3, 3).len(), 4);
}
#[test]
fn test_neighbours_2() {
    assert_eq!(neighbours(0, 0, 3, 3).len(), 2);
}
#[test]
fn test_neighbours_3() {
    assert_eq!(neighbours(1, 0, 3, 3).len(), 3);
}
