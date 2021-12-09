use itertools::Itertools;
use std::collections::HashSet;

type Board = Vec<Vec<i32>>;

fn parse_board(input: &str) -> Board {
    input
        .split('\n')
        .map(|line| line.bytes().map(|b| (b - 48) as i32).collect::<Vec<_>>())
        .collect::<Vec<_>>()
}

fn board_size(board: &Board) -> (usize, usize) {
    let w = board[0].len();
    let h = board.len();
    (w, h)
}

fn neighbours_min(board: &Board, x: usize, y: usize) -> i32 {
    let mut min = 9;
    let (w, h) = board_size(board);
    for (x, y) in neighbours(x, y, w, h) {
        min = board[y][x].min(min);
    }
    min
}

fn neighbours(x: usize, y: usize, w: usize, h: usize) -> Vec<(usize, usize)> {
    let x = x as i32;
    let y = y as i32;
    [(-1, 0), (1, 0), (0, -1), (0, 1)]
        .iter()
        .map(|(kx, ky)| ((x + *kx) as usize, (y + *ky) as usize))
        .filter(|(x, y)| x < &w && y < &h)
        .collect_vec()
}

fn basin_area(board: &Board, visited: &mut HashSet<(usize, usize)>, x: usize, y: usize) -> i32 {
    if visited.contains(&(x, y)) {
        return 0;
    }
    if board[y][x] == 9 {
        return 0;
    }
    let mut area = 1;
    visited.insert((x, y));
    let (w, h) = board_size(board);

    for (x, y) in neighbours(x, y, w, h) {
        area += basin_area(board, visited, x, y)
    }

    area
}

fn low_points(board: &Board) -> Vec<(usize, usize)> {
    let mut points = vec![];
    for (y, row) in board.iter().enumerate() {
        for (x, v) in row.iter().enumerate() {
            if *v < neighbours_min(&board, x, y) {
                points.push((x, y));
            }
        }
    }
    points
}

fn main() {
    let board = parse_board(include_str!("input.txt"));
    let mut sum = 0;
    for (x, y) in low_points(&board) {
        println!("{:?} {:?}", x, y);
        sum += 1 + board[y][x];
    }
    println!("part1: {}", sum);

    let mut areas: Vec<(i32, usize, usize)> = Vec::new();

    for (x, y) in low_points(&board) {
        let mut visited = HashSet::new();
        areas.push((basin_area(&board, &mut visited, x, y), x, y));
    }
    areas.sort_by_key(|k| -k.0);
    let result = &areas[0..3].iter().map(|v| v.0).fold(1, |a, v| a * v);
    println!("part2: {}", result);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test1() {}
}
