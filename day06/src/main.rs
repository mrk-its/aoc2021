#![no_std]
#![feature(start)]
utils::entry!(main);
use ufmt_stdio::*;

type BigInt = u64;

type Population = [BigInt; 10];


fn parse(data: &str) -> Population {
    let mut population: Population = Default::default();
    // changing below to parse::<u64> hangs compilation forever!
    for i in data.split(',').map(|v| v.parse::<i8>().unwrap()) {
        population[i as usize] += 1;
    }
    population
}

fn simulate(population: &Population, steps: u16) -> BigInt {
    let mut population = *population;

    for _ in 0..steps {
        let mut new_population: Population = Default::default();

        for k in 0..10 {
            let v = population[k];
            if k > 0 {
                new_population[k - 1] += v;
            } else {
                new_population[6] += v;
                new_population[8] += v;
            }
        }

        population = new_population;
    }
    population.iter().fold(0, |a, v| a + v)
}

fn main() {
    let data = include_str!("input.txt");
    let population = parse(data);

    let part1 = simulate(&population, 80);
    println!("part1: {}", part1);

    let part2 = simulate(&population, 256);
    println!("part2: {}", part2);
}
