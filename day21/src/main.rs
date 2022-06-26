// 6502: too big, game_tree uses cache with size sizeof(u64) * 10000

use std::collections::HashMap;

struct DeterministicDice {
    value: usize,
    sides: usize,
}

impl DeterministicDice {
    fn new(sides: usize) -> Self {
        Self { value: 0, sides }
    }
}

impl Iterator for DeterministicDice {
    type Item = usize;
    fn next(&mut self) -> Option<Self::Item> {
        let value = self.value;
        self.value = (self.value + 1) % self.sides;
        return Some(value + 1);
    }
}

fn game(
    dice: &mut impl Iterator<Item = usize>,
    mut positions: [usize; 2],
    scores: &mut [usize; 2],
    score_limit: usize,
) -> (usize, usize) {
    let mut player = 0;
    let mut cnt = 0;
    loop {
        let value: usize = dice.next().unwrap() + dice.next().unwrap() + dice.next().unwrap();
        cnt += 3;

        positions[player] = (positions[player] + value) % 10;
        scores[player] += positions[player] + 1;
        if scores[player] >= score_limit {
            return (player, cnt);
        }
        player = (player + 1) % 2;
    }
}

fn game_tree(
    player: usize,
    moves: Vec<usize>,
    positions: [usize; 2],
    scores: [usize; 2],
    max_score: usize,
    cnt: u64,
    cache: &mut HashMap<(usize, [usize; 2], [usize; 2]), u64>,
    level: u32,
    max_level: &mut u32,
) -> u64 {
    if level > *max_level {
        *max_level = level;
        println!("max_level: {:?}, cache: {:?}", max_level, cache.len());
    }
    let key = &(player, positions, scores);
    if cache.contains_key(key) {
        return *cache.get(key).unwrap();
    }
    let mut cnt2 = 0;
    for a in 1..=3 {
        for b in 1..=3 {
            for c in 1..=3 {
                let m = a + b + c;
                let mut new_moves = moves.clone();
                new_moves.push(m);
                let mut new_positions = positions;
                let mut new_scores = scores;
                new_positions[player] = (new_positions[player] + m) % 10;
                new_scores[player] += new_positions[player] + 1;
                if new_scores[player] < max_score {
                    cnt2 += game_tree(
                        (player + 1) & 1,
                        new_moves,
                        new_positions,
                        new_scores,
                        max_score,
                        cnt,
                        cache,
                        level + 1,
                        max_level,
                    );
                } else {
                    if player == 0 {
                        cnt2 += 1;
                    }
                    // println!("{:?} {:?} won: {:?}", new_moves, new_scores, player == 0);
                }
            }
        }
    }

    cache.insert(*key, cnt2);
    cnt2
}

fn main() {
    let mut dice1 = DeterministicDice::new(100);
    let mut scores1 = [0; 2];
    let (winner1, cnt) = game(&mut dice1, [5, 3], &mut scores1, 1000);
    println!("part1: {}", scores1[(winner1 + 1) & 1] * cnt);

    let mut max_level = 0;

    let cnt = game_tree(
        0,
        Vec::new(),
        [6 - 1, 4 - 1],
        [0, 0],
        21,
        0,
        &mut HashMap::new(),
        0,
        &mut max_level,
    );
    println!("cnt: {}", cnt);
}

#[test]
fn test1() {
    let mut dice1 = DeterministicDice::new(100);
    let mut scores1 = [0; 2];
    let (winner1, cnt) = game(&mut dice1, [3, 7], &mut scores1, 1000);
    assert_eq!(scores1[(winner1 + 1) & 1] * cnt, 739785);
}
