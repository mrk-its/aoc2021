fn main() {

    let input = include_str!("input.txt");

    let lines: Vec<_> = input.split("\n").map(|line| line.bytes().map(|v| v & 1).collect::<Vec<_>>()).collect();
    const BITS: usize = 12;
    const MASK: u32 = (1 << BITS) - 1;

    fn most_common(lines: &Vec<Vec<u8>>) -> Vec<u8> {
        let mut counters = [0; BITS];
        for line in lines {
            for (index, char) in line.iter().enumerate() {
                counters[index] += (char & 1) as i32;
            }
        };
        counters.iter().map(|v| (*v >= lines.len() as i32 - *v) as u8).collect()
    }

    let counters = most_common(&lines);

    fn get_value(bits: &[u8]) -> u32 {
        return bits.iter().enumerate().map(|(i, v)| (1 << (BITS - 1 -i)) as u32 * *v as u32).fold(0, |a, v| a + v);
    }

    let gamma = get_value(&counters);
    let epsilon = (!gamma) & MASK;

    println!("{} * {} = {}", gamma, epsilon, gamma * epsilon);
    // assert!(gamma * epsilon == 1092896);


    let mut input = lines.clone();
    for bit_index in 0..BITS {
        let cnt = most_common(&input);
        println!("{:?} {:?}", input, cnt);
        input = input.iter().filter(|l| l[bit_index] == cnt[bit_index]).cloned().collect();
        if input.len() == 1 {
            break;
        }
    };
    assert!(input.len() == 1);
    let o2 = get_value(&input[0]);
    println!("o2: {}", o2);

    let mut input = lines.clone();
    for bit_index in 0..BITS {
        let cnt = most_common(&input);
        input = input.iter().filter(|l| l[bit_index] == (!cnt[bit_index])&1).cloned().collect();
        if input.len() == 1 {
            break;
        }
    };
    assert!(input.len() == 1);
    let co2 = get_value(&input[0]);

    println!("co2: {}", co2);
    println!("{}", o2 * co2);

}
