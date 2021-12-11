use std::collections::HashMap;

fn main() {
    let data = include_str!("input.txt");

    let parsed = data.split(',').map(|v| v.parse::<i64>().unwrap()).collect::<Vec<_>>();

    let mut population: HashMap<i64, i64> =  Default::default();

    for i in parsed {
        let cnt = population.entry(i).or_default();
        *cnt = *cnt + 1;
    }

    for _ in 0..256 {
        let mut new_population: HashMap<i64, i64> = Default::default();

        for (k, v) in population.iter() {
            if *k > 0 {
                *new_population.entry(*k - 1).or_default() += v;
            } else {
                *new_population.entry(6).or_default() += v;
                *new_population.entry(8).or_default() += v;
            }
        }

        population = new_population;

        println!("{:?}", population);
    }

    println!("{:?}", population.values().fold(0, |a, v| a + v ));
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test1() {
    }
}
