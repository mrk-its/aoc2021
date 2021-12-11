use itertools::Itertools;
use std::{collections::HashSet, time::Duration};

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

fn neighbours(x: usize, y: usize, w: usize, h: usize) -> Vec<(usize, usize)> {
    let x = x as i32;
    let y = y as i32;

    let dirs = (-1..=1)
        .flat_map(|y| (-1..=1).map(move |x| (x, y)))
        .filter(|(x, y)| *x != 0 || *y != 0)
        .collect_vec();

    dirs
        .iter()
        .map(|(kx, ky)| ((x + *kx) as usize, (y + *ky) as usize))
        .filter(|(x, y)| x < &w && y < &h)
        .collect_vec()
}

fn step(board: &mut Board, flash_cnt: &mut i32) {
    let (w, h) = board_size(board);
    let mut flashed: HashSet<(usize, usize)> = HashSet::new();
    for row in board.iter_mut() {
        for energy in row {
            *energy += 1
        }
    };
    loop {
        let prev_flash_cnt = *flash_cnt;
        for y in 0..h {
            for x in 0..w {
                if board[y][x] > 9 && !flashed.contains(&(x, y)) {
                    *flash_cnt += 1;
                    // flash!
                    for (nx, ny) in neighbours(x, y, w, h) {
                        board[ny][nx] += 1;
                    }
                    flashed.insert((x, y));
                }
            }
        }
        if *flash_cnt == prev_flash_cnt {
            break;
        }
    }
    for row in board.iter_mut() {
        for energy in row {
            if *energy > 9 {
                *energy = 0;
            }
        }
    };
}

fn show(board: &Board) {
    for row in board {
        println!("{}", row.iter().map(|e| char::from_u32(48 + *e as u32).unwrap()).collect::<String>());
    }
}

fn main() {
    let mut board = parse_board(include_str!("input.txt"));
    let (w, h) = board_size(&board);
    show(&board);
    let mut part1_cnt = 0;
    let mut flash_cnt = 0;
    let mut n_step = 0;
    loop {
        let before = flash_cnt;
        step(&mut board, &mut flash_cnt);
        let just_flashed = flash_cnt - before;
        show(&board);
        println!();
        std::thread::sleep(Duration::from_millis(50));
        n_step += 1;
        if n_step == 100 {
            part1_cnt = flash_cnt;
        }
        if just_flashed == (w * h) as i32 {
            break;
        }
    }
    println!("part1: {}", part1_cnt);
    println!("part2: {}", n_step);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_neighbours_1() {
        assert_eq!(neighbours(1, 1, 3, 3).len(), 8);
    }
    #[test]
    fn test_neighbours_2() {
        assert_eq!(neighbours(0, 0, 3, 3).len(), 3);
    }
    #[test]
    fn test_neighbours_3() {
        assert_eq!(neighbours(1, 0, 3, 3).len(), 5);
    }
}
