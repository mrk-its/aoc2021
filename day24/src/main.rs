#![no_std]
#![feature(start)]

utils::entry!(main);
extern crate alloc;
extern crate mos_alloc;
use alloc::boxed::Box;
use alloc::vec::Vec;

use ufmt_stdio::*;

enum Op {
    Reg(usize),
    Imm(i32),
}

enum Instr {
    Inp(Op),
    Add(Op, Op),
    Mul(Op, Op),
    Div(Op, Op),
    Mod(Op, Op),
    Eql(Op, Op),
}

fn parse_op(input: &[u8]) -> Op {
    match input {
        b"w" => Op::Reg(0),
        b"x" => Op::Reg(1),
        b"y" => Op::Reg(2),
        b"z" => Op::Reg(3),
        _ => Op::Imm(utils::to_str(input).parse::<i32>().unwrap()),
    }
}

fn parse_program<'a>(lines: impl Iterator<Item = &'a [u8]>) -> Vec<Instr> {
    lines
        .map(|line| {
            let v = line.split(|c| *c == b' ').collect::<Vec<_>>();
            match v[0] {
                b"inp" => Instr::Inp(parse_op(v[1])),
                b"add" => Instr::Add(parse_op(v[1]), parse_op(v[2])),
                b"mul" => Instr::Mul(parse_op(v[1]), parse_op(v[2])),
                b"div" => Instr::Div(parse_op(v[1]), parse_op(v[2])),
                b"eql" => Instr::Eql(parse_op(v[1]), parse_op(v[2])),
                b"mod" => Instr::Mod(parse_op(v[1]), parse_op(v[2])),
                _ => panic!(),
            }
        })
        .collect()
}

fn run_program(program: &[Instr], regs: &mut [i32; 4], input: &[i32]) {
    let mut input_index = 0;
    for instr in program {
        match instr {
            &Instr::Inp(Op::Reg(n)) => {
                regs[n] = input[input_index];
                input_index += 1
            }
            &Instr::Add(Op::Reg(a), Op::Reg(b)) => regs[a] = regs[a] + regs[b],
            &Instr::Add(Op::Reg(a), Op::Imm(b)) => regs[a] = regs[a] + b,
            &Instr::Mul(Op::Reg(a), Op::Reg(b)) => regs[a] = regs[a] * regs[b],
            &Instr::Mul(Op::Reg(a), Op::Imm(b)) => regs[a] = regs[a] * b,
            &Instr::Div(Op::Reg(a), Op::Reg(b)) => regs[a] = regs[a] / regs[b],
            &Instr::Div(Op::Reg(a), Op::Imm(b)) => regs[a] = regs[a] / b,
            &Instr::Mod(Op::Reg(a), Op::Reg(b)) => regs[a] = regs[a].rem_euclid(regs[b]),
            &Instr::Mod(Op::Reg(a), Op::Imm(b)) => regs[a] = regs[a].rem_euclid(b),
            &Instr::Eql(Op::Reg(a), Op::Reg(b)) => regs[a] = if regs[a] == regs[b] { 1 } else { 0 },
            &Instr::Eql(Op::Reg(a), Op::Imm(b)) => regs[a] = if regs[a] == b { 1 } else { 0 },
            _ => panic!(),
        }
    }
}

fn f(regs: &mut [i32; 4], input: i32, p1: i32, p2: i32, p3: i32) {
    let x = (regs[3] % 26) + p2; // 12
    regs[3] = regs[3] / p1; // 0
    regs[1] = if x == input { 0 } else { 1 }; // 1

    regs[3] = regs[3] * (25 * regs[1] + 1); // 0
    regs[2] = (input + p3) * regs[1]; // input + 6
    regs[3] += regs[2]; // input + 6
}

fn run_program2(regs: &mut [i32; 4], input: &[i32]) {
    // f(regs, input[0], 1, 12, 6);
    // f(regs, input[1], 1, 11, 12);
    // f(regs, input[2], 1, 10, 5);
    // f(regs, input[3], 1, 10, 10);
    // f(regs, input[4], 26, -16, 7);
    // f(regs, input[5], 1, 14, 0);
    // f(regs, input[6], 1, 12, 4);
    // f(regs, input[7], 26, -4, 12);
    // f(regs, input[8], 1, 15, 14);
    // f(regs, input[9], 26, -7, 13);
    f(regs, input[10], 26, -8, 10);
    f(regs, input[11], 26, -4, 11);
    f(regs, input[12], 26, -15, 9);
    f(regs, input[13], 26, -8, 9);
}

fn dec(input: &mut [i32]) -> bool {
    for idx in (0..input.len()).rev() {
        input[idx] = input[idx] - 1;
        if input[idx] <= 0 {
            input[idx] = 9;
            if idx == 0 {
                return true;
            }
        } else {
            break;
        }
    }
    return false;
}

fn inc(input: &mut [i32]) -> bool {
    for idx in (0..input.len()).rev() {
        input[idx] = input[idx] + 1;
        if input[idx] > 9 {
            input[idx] = 1;
            if idx == 0 {
                return true;
            }
        } else {
            break;
        }
    }
    return false;
}

fn find_serials(input: [i32; 14], cb: fn(&mut [i32]) -> bool) -> Option<[i32; 14]> {
    let monad = parse_program(utils::iter_lines!("input.txt"));
    let mut input = input;

    loop {
        let mut regs: [i32; 4] = [0; 4];
        run_program(&monad[0..18 * 5], &mut regs, &input);
        if regs[1] == 0 {
            println!("input: {:?}", input);
            loop {
                let mut regs2 = regs;
                run_program(&monad[18 * 5..18 * 8], &mut regs2, &input[5..8]);
                if regs2[1] == 0 {
                    loop {
                        let mut regs3 = regs2;
                        run_program(&monad[18 * 8..18 * 10], &mut regs3, &input[8..10]);
                        if regs3[1] == 0 {
                            // println!("    input: {:?}, out: {:?}", input, regs);
                            loop {
                                let mut regs4: [i32; 4] = regs3;
                                // run_program(&monad[18*10..], &mut regs4, &input[10..]);
                                run_program2(&mut regs4, &input);
                                // let mut regs4 = regs3;
                                // run_program(&monad[18*10..], &mut regs4, &input[10..]);
                                if regs4[3] == 0 {
                                    return Some(input);
                                }
                                if cb(&mut input[10..]) {
                                    break;
                                }
                            }
                        }
                        if cb(&mut input[8..10]) {
                            break;
                        }
                    }
                }
                if cb(&mut input[5..8]) {
                    break;
                }
            }
        }
        if cb(&mut input[..5]) {
            break;
        }
    }
    None
}

fn main() {
    let part1 = find_serials([9; 14], dec);
    println!("part1: {:?}", part1);
    let part2 = find_serials([1; 14], inc);
    println!("part2: {:?}", part2);
}

#[test]
fn test_1() {
    let program = parse_program(include_str!("test_input1.txt"));
    for i in 0..16 {
        let mut regs: [i32; 4] = [0; 4];
        run_program(&program, &mut regs, &[i]);
        println!("{:?}", regs);
    }
}

fn test_2() {
    // 99999762482423
    // [9, 9, 9, 9, 3, 9, 9, 9, 9, 4, 9, 5, 6, 7]
}
