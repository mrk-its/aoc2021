use std::collections::{HashMap, HashSet};

type Board = HashMap<(i32, i32), i32>;

fn point(board: &mut Board, coords: (i32, i32)) {
    // println!("paint {:?}", coords);
    let v = board.entry(coords).or_default();
    *v += 1;
}

fn draw(board: &mut Board, p1: (i32, i32), p2: (i32, i32)) {
    // println!("draw");
    let dx = (p2.0 - p1.0).signum();
    let dy = (p2.1 - p1.1).signum();

    let mut p = p1;

    point(board, p);

    while p != p2 {
        p = (p.0 + dx, p.1 + dy);
        point(board, p);
    }
}

fn main() {
    let data = include_str!("input.txt");
    let parsed = data
        .split('\n')
        .map(|row| {
            row.split(" -> ")
                .map(|coords| {
                    coords
                        .split(',')
                        .map(|v| v.parse::<i32>().unwrap())
                        .collect::<Vec<_>>()
                })
                .collect::<Vec<_>>()
        })
        .map(|line| ((line[0][0], line[0][1]), (line[1][0], line[1][1])))
        .collect::<Vec<_>>();

    let mut board = Board::default();

    for (p1, p2) in parsed
        .iter()
        .filter(|(p1, p2)| p1.0 == p2.0 || p1.1 == p2.1)
    {
        draw(&mut board, *p1, *p2);
    }
    let count = board.iter().filter(|v| *v.1 > 1).count();
    println!("{}", count);

    let mut board = Board::default();

    for (p1, p2) in parsed.iter() {
        draw(&mut board, *p1, *p2);
    }

    let count = board.iter().filter(|v| *v.1 > 1).count();
    println!("{}", count);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test1() {
        let mut board = Board::default();
        draw(&mut board, (0, 0), (0, 0));
        draw(&mut board, (0, 0), (0, 1));
        println!("board: {:?}", board);
    }
}
