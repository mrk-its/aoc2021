// 6502: change board representation from HashMap to bitmap

use std::collections::HashMap;

type Pixel = u16;
type Alg = Vec<Pixel>;

type Pos = (i32, i32);

type ImageData = HashMap<Pos, Pixel>;

#[derive(Debug, Clone)]
struct Image {
    data: ImageData,
    bounds: (Pos, Pos),
    default: Pixel,
}

fn parse_char(c: char) -> Pixel {
    if c == '.' {
        0u16
    } else {
        1u16
    }
}

fn pixel(image: &Image, pos: &Pos) -> Pixel {
    *image.data.get(pos).unwrap_or(&image.default)
}

fn parse(input: &str) -> (Alg, Image) {
    let mut parts = input.split("\n\n");
    let alg = parts
        .next()
        .unwrap()
        .chars()
        .map(parse_char)
        .collect::<Vec<_>>();
    let image = parts.next().unwrap();
    let data = image
        .split("\n")
        .enumerate()
        .flat_map(|(j, line)| {
            line.chars()
                .enumerate()
                .map(move |(i, c)| ((i as i32, j as i32), parse_char(c)))
        })
        .collect::<HashMap<_, _>>();
    let bounds = bounds(&data);
    let image = Image {
        data,
        bounds,
        default: 0,
    };
    (alg, image)
}
fn bounds(image: &ImageData) -> (Pos, Pos) {
    image.keys().fold(
        ((0, 0), (0, 0)),
        |((min_x, min_y), (max_x, max_y)), (x, y)| {
            (
                (min_x.min(*x), min_y.min(*y)),
                (max_x.max(*x), max_y.max(*y)),
            )
        },
    )
}

fn offs(image: &Image, (x, y): Pos) -> usize {
    ((pixel(image, &(x - 1, y - 1)) << 8)
    + (pixel(image, &(x, y - 1)) << 7)
    + (pixel(image, &(x + 1, y - 1)) << 6)
    + (pixel(image, &(x - 1, y)) << 5)
    + (pixel(image, &(x, y)) << 4)
    + (pixel(image, &(x + 1, y)) << 3)
    + (pixel(image, &(x - 1, y + 1)) << 2)
    + (pixel(image, &(x, y + 1)) << 1)
    + (pixel(image, &(x + 1, y + 1)) << 0)) as usize
}

fn enhance(image: &Image, alg: &Alg) -> Image {
    let margin = 1;
    let (min, max)= image.bounds;
    let (min, max) = ((min.0 - margin, min.1 - margin), (max.0 + margin, max.1 + margin));

    let mut data = HashMap::new();

    for y in min.1..=max.1 {
        for x in min.0..=max.0 {
            let v = offs(image, (x, y));
            data.insert((x, y), alg[v as usize]);
        }
    }

    let index = if image.default == 0 {0} else {511};

    Image { data, bounds: (min, max), default: alg[index]}
}

fn show(image: &Image) {
    let (lo, hi) = image.bounds;
    for y in lo.1..=hi.1 {
        for x in lo.0..=hi.0 {
            print!("{}", if image.data.get(&(x, y)).unwrap() > &0 {'#'} else {'.'});
        }
        println!();
    }
    println!();
}

fn do_it(image: &Image, alg: &Alg, n: usize) -> usize {
    show(&image);

    let mut image = image.clone();

    for i in 0..n {
        image = enhance(&image, alg);
        if i % 2 != 0 {
            show(&image);
        }
    }
    let ones = image.data.values().cloned().filter(|&v| v > 0).count();
    ones
}

fn main() {
    let (alg, image) = parse(include_str!("input.txt"));
    println!("alg: {:?}", alg);
    println!("part1: {}", do_it(&image, &alg, 2));
    println!("part2: {}", do_it(&image, &alg, 50));
}

#[test]
fn test_offs() {
    let (alg, image) = parse(include_str!("test_input1.txt"));
    assert_eq!(pixel(&image, &(0, 0)), 1);
    assert_eq!(pixel(&image, &(2, 2)), 0);
    assert_eq!(offs(&image, (2, 2)), 34);
}

#[test]
fn test_offs2() {
    let (alg, image) = parse(include_str!("test_input2.txt"));
    assert_eq!(offs(&image, (1, 1)), 511);
    let enh = enhance(&image, &alg);
    show(&enh);
}


#[test]
fn test_part1() {
    let (alg, image) = parse(include_str!("test_input1.txt"));
    assert_eq!( do_it(&image, &alg, 2), 35);
}