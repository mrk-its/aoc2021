type Board = Vec<Vec<char>>;

type Pos = (usize, usize);

const ROOMS: &[[Pos; 4]] = &[
    [(3, 5), (3, 4), (3, 3), (3, 2)],
    [(5, 5), (5, 4), (5, 3), (5, 2)],
    [(7, 5), (7, 4), (7, 3), (7, 2)],
    [(9, 5), (9, 4), (9, 3), (9, 2)],
];

const OPENSPACE: &[Pos] = &[
    (1, 1),
    (2, 1),
    // (3, 1),
    (4, 1),
    // (5, 1),
    (6, 1),
    // (7, 1),
    (8, 1),
    // (9, 1),
    (10, 1),
    (11, 1),
];

const AMPS: &[char] = &['A', 'B', 'C', 'D'];


fn parse(input: &str) -> Board {
    input.split('\n').map(|line| line.chars().collect()).collect()
}

fn show(board: &Board) {
    board.iter().for_each(|row| println!("{}", row.iter().collect::<String>()));
    println!();
}

fn get(board: &Board, pos: Pos) -> Option<char> {
    let c = board[pos.1][pos.0];
    if c != '.' {
        Some(c)
    } else {
        None
    }
}
fn set(board: &mut Board, pos: Pos, c: char) {
    board[pos.1][pos.0] = c;
}

fn energy(c: char) -> i32 {
    match c {
        'A' => 1,
        'B' => 10,
        'C' => 100,
        'D' => 1000,
        _ => panic!("No dest room for {:?}", c),
    }
}

fn dest_room(board: &Board, c: char, n: usize) -> Option<Pos> {
    let index = match c {
        'A' => 0,
        'B' => 1,
        'C' => 2,
        'D' => 3,
        _ => panic!("No dest room for {:?}", c),
    };
    let room = ROOMS[index];
    let r0 = get(board, room[0]);
    let r1 = get(board, room[1]);
    let r2 = get(board, room[2]);
    let r3 = get(board, room[3]);
    if n == 0 && r0 == None && r1 == None && r2 == None && r3 == None {
        return Some(room[0]);
    }

    if n == 1 && r0 == Some(c) && r1 == None && r2 == None && r3 == None {
        return Some(room[1]);
    }

    if n == 2 && r0 == Some(c) && r1 == Some(c) && r2 == None && r3 == None {
        return Some(room[2]);
    }

    if n == 3 && r0 == Some(c) && r1 == Some(c) && r2 == Some(c) && r3 == None {
        return Some(room[3]);
    }
    None
}

fn possible_moves(board: &Board) -> Vec<(Pos, Pos)> {
    let mut out = Vec::new();
    for (room, amp) in ROOMS.iter().zip(AMPS.iter()) {
        for i in 0..4 {
            let i = 3-i;
            let src = room[i];
            if let Some(c) = get(board, src) {
                if c != *amp || (0..i).any(|p| get(board, room[p]) != Some(*amp)) {
                    for n in 0..4 {
                        if let Some(dest) = dest_room(board, c, n) {
                            out.push((src, dest));
                        }
                    }
    
                    // find dest openspace
                    for &pos in OPENSPACE.iter() {
                        if get(board, pos) == None {
                            out.push((src, pos))
                        }
                    }                       

                }
            }    
        }
    }
    for &pos in OPENSPACE.iter() {
        if let Some(c) = get(board, pos) {
            for n in 0..4 {
                if let Some(dest) = dest_room(board, c, n) {
                    out.push((pos, dest));
                }    
            }
        }
    }
    out
}

fn do_move(board: &mut Board, src: Pos, dst: Pos) {
    assert!(get(board, dst) == None);
    let amp = get(board, src).unwrap();
    set(board, dst, amp);
    set(board, src, '.');
    //println!("{}: {:?} -> {:?}", amp, src, dst);
    // show(board)
}

fn get_cost(board: &Board, src: Pos, dst: Pos, cost: i32) -> Option<i32> {
    if src == dst {
        return Some(cost)
    }
    let src_hall = src.1 == 1;
    let dst_hall = dst.1 == 1;
    
    let src= match (src_hall, dst_hall) {
        (true, true) => {
            ((src.0 as i32 + (dst.0 as i32 - src.0 as i32).signum()) as usize, src.1)
        },
        (false, true) => {
            // room -> hall
            (src.0, src.1 - 1)
        }
        (false, false) => {
            // room -> room
            if src.0 != dst.0 {
                // moving out from room
                (src.0, src.1 - 1)
            } else {
                // moving into
                (src.0, src.1 + 1)
            }
        }
        (true, false) => {
            // hall -> room
            if src.0 != dst.0 {
                ((src.0 as i32 + (dst.0 as i32 - src.0 as i32).signum()) as usize, src.1)
            } else {
                (src.0, (src.1 as i32 + (dst.1 as i32 - src.1 as i32).signum()) as usize)
            }
        }
    };
    if get(board, src).is_some() {
        return None
    }

    get_cost(board, src, dst, cost + 1 as i32)
}

fn is_finished(board: &Board) -> bool {
    return ROOMS.iter().zip(AMPS).all(|(room, &amp)| room.iter().all(|&pos| get(board, pos) == Some(amp)))
}

const PATH: &[(Pos, Pos)] = &[
    // (ROOMS[3][3], OPENSPACE[6]),
    // (ROOMS[3][2], OPENSPACE[0]),
    // (ROOMS[2][3], OPENSPACE[5]),
    // (ROOMS[2][2], OPENSPACE[4]),
    // (ROOMS[2][1], OPENSPACE[1]),
    ];

fn moves(board: &Board, depth: usize, total_cost: i32, min_cost: &mut i32) {
    if total_cost >= *min_cost {
        return
    }
    // show(board);
    let mut pmoves = possible_moves(board);
    pmoves = pmoves.iter().filter(|x| get_cost(board, x.0, x.1, 0).is_some()).cloned().collect();
    pmoves.sort_by_cached_key(|x|  get_cost(board, x.0, x.1, 0).unwrap());
    // println!("depth: {}, {:?}", depth, pmoves);
    if depth < PATH.len() {
        assert!(pmoves.contains(&PATH[depth]));
        pmoves = vec![PATH[depth]];
    }
    let mut moved = false;
    for (n, (src, dst)) in pmoves.iter().enumerate() {
        if depth < 2 {
            println!("{} {}", depth, n);
        }
        if let Some(cost) = get_cost(board, *src, *dst, 0) {
            let cost = cost * energy(get(board, *src).unwrap());

            moved = true;
            let mut b = board.clone();
            do_move(&mut b, *src, *dst);
            // show(board);
            // println!("cost: {}", cost);
            moves(&b, depth + 1, cost + total_cost, min_cost);
        }
    }
    if !moved && is_finished(board) {
        if total_cost < *min_cost {
            println!("NEW BEST: {:?}", total_cost);
            show(board);
            *min_cost = total_cost;
        }
    }
}

fn main() {
    let board = parse(include_str!("input2.txt"));
    show(&board);
    let mut min_cost = i32::MAX;
    moves(&board, 0, 0, &mut min_cost);

    show(&board);
    println!("part2: {:?}", min_cost);

}

#[test]
fn test() {
    let board = parse(include_str!("test_input2.txt"));
    show(&board);
    let mut min_cost = i32::MAX;
    moves(&board, 0, 0, &mut min_cost);

    show(&board);
    println!("part1: {:?}", min_cost);
}