use std::{env, fs, path::Path};

fn parse(input: &str) -> Vec<Vec<char>> {
    input
        .split('\n')
        .map(|line| line.chars().collect())
        .collect()
}

fn main() {
    let data = parse(include_str!("src/input.txt"));

    let out_dir = env::var("OUT_DIR").unwrap();
    let dest_path = Path::new(&out_dir).join("input.rs");

    let mut array_string = String::new();
    let w = data[0].len();
    let row_w = (w + 3) / 4;
    let h = data.len();

    let data = data
        .iter()
        .flat_map(|row| {
            row.chunks(4)
                .map(|chunk| {
                    chunk.iter().enumerate().fold(0u8, |a, (i, c)| {
                        a | (match *c {
                            '>' => 1,
                            'v' => 2,
                            _ => 0,
                        } << (6 - i * 2))
                    })
                })
                .collect::<Vec<_>>()
        })
        .collect::<Vec<_>>();

    array_string.push_str(&format!("pub type Board = [u8; {}];\n", row_w * h));
    array_string.push_str(&format!("pub const INPUT: Board = {:?};\n", data));
    array_string.push_str(&format!(
        "pub const INPUT_SIZE: (usize, usize) = {:?};\nconst ROW_SIZE: usize = {};",
        (w, h),
        row_w
    ));

    fs::write(&dest_path, array_string).unwrap();
}
