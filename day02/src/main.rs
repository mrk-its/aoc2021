#![no_std]
#![feature(start)]

#[start]
fn main(_argc: isize, _argv: *const *const u8) -> isize {
    let mut pos = 0;
    let mut depth = 0;

    let parsed = include_bytes!("input.txt").split(|c| *c == b'\n').map(|line| {
        let mut p = line.split(|c| *c == b' ');
        let dir = p.next().unwrap();
        let n = p.next().unwrap();
        (dir[0], n[0]-48)
    });

    // string pattern matching doesn't work!
    // 

    for (dir, n) in parsed.clone() {
        let n = n as i32;
        match dir {
            b'f' => pos += n,
            b'd' => depth += n,
            b'u' => depth -= n,
            _ => panic!(),
        }
    }
    io::write("part1: ");
    io::write_int(pos * depth);
    io::writeln();

    let mut pos = 0;
    let mut depth = 0;
    let mut aim = 0;

    for (dir, n) in parsed.clone() {
        let n = n as u32;
        match dir {
            b'f' => {pos += n; depth += aim * n;}
            b'd' => aim += n,
            b'u' => aim -= n,
            _ => panic!()
        }
    }
    io::write("part2: ");
    io::write_int(pos * depth);
    io::writeln();

    #[cfg(target_arch="mos")]
    loop {}

    #[cfg(not(target_arch="mos"))]
    0
}
