type Board = Vec<Vec<char>>;

fn parse(input: &str) -> Board {
    input.split('\n').map(|line| line.chars().collect()).collect()
}

fn show(board: &Board) {
    board.iter().for_each(|line| {
        line.iter().for_each(|c| print!("{}", c));
        println!();
    });
    println!();
}

fn mv_east(board: &Board) -> (Board, bool) { 
    let mut new_board = board.clone();
    let mut moved = false;
    for (j, row) in board.iter().enumerate() {
        for (i, c) in row.iter().enumerate() {
            let new_pos = (i + 1) % row.len();
            if *c == '>' && row[new_pos] == '.' {
                new_board[j][new_pos] = '>';
                new_board[j][i] = '.';
                moved = true;
            }
        }
    }
    return (new_board, moved)
}

fn mv_south(board: &Board) -> (Board, bool) { 
    let mut new_board = board.clone();
    let mut moved = false;
    for (j, row) in board.iter().enumerate() {
        for (i, c) in row.iter().enumerate() {
            let new_pos = (j + 1) % board.len();
            if *c == 'v' && board[new_pos][i] == '.' {
                new_board[new_pos][i] = 'v';
                new_board[j][i] = '.';
                moved = true;
            }
        }
    }
    return (new_board, moved)
}
fn mv(board: &Board) -> (Board, bool) {
    let (board, moved1) = mv_east(board);
    let (board, moved2) = mv_south(&board);
    (board, moved1 || moved2)
}


fn main() {
    let mut board = parse(include_str!("input.txt"));
    show(&board);
    let mut cnt = 0;
    loop {
        let (new_board, moved) = mv(&board);
        cnt += 1;
        board = new_board;
        show(&board);    
        if !moved {
            break;
        }
    }
    println!("part1: {}", cnt);
}