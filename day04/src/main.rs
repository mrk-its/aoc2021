use std::collections::{HashMap, HashSet};

#[derive(Debug, Default)]
struct Board {
    rows: Vec<Vec<i32>>,
    positions: HashMap<i32, (usize, usize)>,
    marked: HashSet<i32>,
    row_cnt: [i32; 5],
    col_cnt: [i32; 5],
    last_value: i32,
}

fn parse_row(row: &str) -> Vec<i32> {
    row.split(" ")
        .filter(|v| !v.is_empty())
        .map(|v| v.parse().unwrap())
        .collect()
}

impl Board {
    fn new(data: &str) -> Self {
        let mut board = Self {
            rows: data.split("\n").map(parse_row).collect::<Vec<_>>(),
            ..Default::default()
        };

        for (j, row) in board.rows.iter().enumerate() {
            for (i, v) in row.iter().enumerate() {
                board.positions.entry(*v).or_insert((i, j));
            }
        }
        assert!(board.positions.len() == 25);
        board
    }

    fn mark(&mut self, value: i32) -> bool {
        self.last_value = value;
        self.marked.insert(value);
        let value = self.positions.get(&value);
        if let Some((i, j)) = value {
            self.row_cnt[*j] += 1;
            self.col_cnt[*i] += 1;
            return self.row_cnt[*j] == 5 || self.col_cnt[*i] == 5;
        }
        return false;
    }
    fn score(&self) -> i32 {
        let sum = self
            .rows
            .iter()
            .flat_map(|v| v.iter())
            .filter(|v| !self.marked.contains(*v))
            .fold(0, |acc, v| acc + v);
        sum * self.last_value
    }
}

fn main() {
    let data = include_str!("input.txt");
    let mut data = data.split("\n\n");
    let header = data.next().unwrap();
    let numbers: Vec<i32> = header
        .split(",")
        .map(|v| v.parse::<i32>())
        .collect::<Result<Vec<_>, _>>()
        .unwrap();
    println!("header: {:?}", numbers);

    let mut winner_boards: HashSet<usize> = HashSet::default();

    let mut boards = data.map(|data| Board::new(data)).collect::<Vec<_>>();
    for value in numbers {
        for (n, board) in boards.iter_mut().enumerate() {
            if !winner_boards.contains(&n) && board.mark(value) {
                println!("board {} won, score: {}", n, board.score());
                winner_boards.insert(n);
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_split() {
        let parts = " 1   2 3".split(" ").collect::<Vec<&'static str>>();
        println!("parts: {:?}", parts);
    }
}
