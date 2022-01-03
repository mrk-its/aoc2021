#![no_std]
#![feature(start)]
#![allow(unused_imports)]

use staticvec::StaticVec;

use core::panic::PanicInfo;

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    write("PANIC!!!");
    loop {}
}

extern "C" {
    fn __putchar(c: u8);
}

pub fn write(text: &str) {
    text.bytes().for_each(|b| unsafe { __putchar(b) });
}

pub fn write_i16(value: i16) {
    let digit = value % 10;
    let rem = value / 10;
    if rem > 0 {
        write_i16(rem);
    }
    unsafe {
        __putchar(48 + (digit as u8));
    }
}

#[start]
fn main(_argc: isize, _argv: *const *const u8) -> isize {
    let input = include_str!("input.txt");

    write("parsing...");
    let parsed = input
        .split('\n')
        .map(|i| i.parse::<i16>().unwrap())
        .collect::<StaticVec<i16, 2000>>();
    write("done\n");

    let part1 = parsed
        .iter()
        .zip(&parsed[1..])
        .filter(|(a, b)| a < b)
        .count();

    write("part1: ");
    write_i16(part1 as i16);
    write("\n");

    let values = parsed
        .iter()
        .zip(&parsed[1..])
        .zip(&parsed[2..])
        .map(|((a, b), c)| a + b + c);
    let part2 = values
        .clone()
        .zip(values.skip(1))
        .filter(|(a, b)| b > a)
        .count();
    write("part2: ");
    write_i16(part2 as i16);
    write("\n");
    0
}
