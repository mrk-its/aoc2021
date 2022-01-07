#![no_std]
#![feature(start)]
io::entry!(main);

type BigInt = u64;

type Population = [BigInt; 10];

extern "C" {
    fn __muldi3(a: u64, b: u64) -> u64;
}

// for now we have int module commented out on mos arch, so we don't have 128bit support
// but for some reason this program requires 128 bit multiplication __multi3 intrinsic
// and throws: ld.lld: error: undefined symbol: __multi3 during linking
// so let's cheat a bit:

#[no_mangle]
pub unsafe extern "Rust" fn __multi3(a: u128, b: u128) -> u128 {
    return __muldi3(a as u64, b as u64) as u128;
}

// interesting thing - always returning zero from above function produces correct results
// so it seems it is not used at all


fn parse(data: &str) -> Population {
    let mut population: Population =  Default::default();
    for i in data.split(',').map(|v| v.parse::<BigInt>().unwrap()) {
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
                new_population[k-1] += v;
            } else {
                new_population[6] += v;
                new_population[8] += v;
            }
        }

        population = new_population;
    }
    population.iter().fold(0, |a, v| a + v )
}

fn main() {
    let data = include_str!("input.txt");
    let population = parse(data);

    let part1 = simulate(&population, 80);
    io::write("part1: "); io::write_int(part1); io::writeln();

    let part2 = simulate(&population, 256);
    io::write("part2: "); io::write_int(part2); io::writeln();

}
