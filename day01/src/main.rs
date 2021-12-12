use fixedvec::Vec;
fn main() {
    let input = include_str!("input.txt");

    let values = input.split("\n").map(|i| i.parse::<isize>().unwrap()).collect::<Vec<_, 2000>>();

    let values = values.iter().zip(&values[1..]).zip(&values[2..]).map(|((a, b), c)| a + b + c).collect::<Vec<_, 2000>>();

    let result = values.iter().zip(&values[1..]).filter(|(a, b)| b > a).count();

    println!("result: {:?}", result);
}
