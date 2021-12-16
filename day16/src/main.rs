struct BITS {
    data: Vec<u8>,
    bit_pos: usize,
}
#[derive(Debug, PartialEq, Eq)]
enum Kind {
    Literal(u64),
    Operator { kind: u16, packets: Vec<Packet> },
}
#[derive(Debug, PartialEq, Eq)]
struct Packet {
    version: u16,
    kind: Kind,
}

impl Packet {
    fn value(&self) -> u64 {
        match &self.kind {
            Kind::Literal(value) => *value,
            Kind::Operator {kind, packets} => {
                match kind {
                    0 => packets.iter().fold(0, |a, p| a + p.value()),
                    1 => packets.iter().fold(1, |a, p| a * p.value()),
                    2 => packets.iter().map(|p| p.value()).min().unwrap(),
                    3 => packets.iter().map(|p| p.value()).max().unwrap(),
                    5 => (packets[0].value() > packets[1].value()) as u64,
                    6 => (packets[0].value() < packets[1].value()) as u64,
                    7 => (packets[0].value() == packets[1].value()) as u64,
                    _ => panic!(),
                }
            }
        }
    }
}

impl BITS {
    fn from_str(data: &str) -> Self {
        let data = data
            .bytes()
            .map(|b| match b {
                48..=57 => b - 48,
                65..=70 => b - 65 + 10,
                _ => panic!("invalid input"),
            })
            .collect::<Vec<_>>();
        Self { data, bit_pos: 0 }
    }
    fn next_bit(&mut self) -> u16 {
        let bit_pos = self.bit_pos;
        self.bit_pos += 1;
        ((self.data[bit_pos / 4] >> (3 - (bit_pos & 3))) & 1) as u16
    }
    fn next_bits(&mut self, n: i32) -> u16 {
        let mut value = 0;
        for _ in 0..n {
            value = (value << 1) | self.next_bit();
        }
        value
    }
    fn next_packet(&mut self) -> Packet {
        let version = self.next_bits(3);
        let kind = self.next_bits(3);
        let kind = match kind {
            4 => {
                let mut value = 0;
                loop {
                    let chunk = self.next_bits(5);
                    value = value << 4 | (chunk & 0xf) as u64;
                    if chunk < 16 {
                        break;
                    }
                }
                Kind::Literal(value)
            }
            _ => {
                let mut packets = vec![];
                let length_type = self.next_bit();
                if length_type == 0 {
                    let n_bits = self.next_bits(15);
                    let last_bit_pos = self.bit_pos + n_bits as usize;
                    while self.bit_pos < last_bit_pos {
                        packets.push(self.next_packet())
                    }
                } else {
                    let n_packets = self.next_bits(11);
                    for _ in 0..n_packets {
                        packets.push(self.next_packet())
                    }

                }
                Kind::Operator { kind, packets }
            }
        };
        Packet { version, kind }
    }
    fn bits_left(&self) -> usize {
        self.data.len() * 4 - self.bit_pos
    }
}

fn sum_versions(packet: &Packet) -> u64 {
    let mut version = packet.version as u64;
    if let Kind::Operator {packets, ..} = &packet.kind {
        for packet in packets {
            version += sum_versions(packet)
        }
    }
    version
}

fn main() {
    let mut bits = BITS::from_str(include_str!("input.txt"));
    let packet = bits.next_packet();
    println!("part1: {}", sum_versions(&packet));
    println!("part2: {}", packet.value());

}

#[test]
fn test_bits_1() {
    let mut bits = BITS::from_str("D2FE28");
    assert_eq!(bits.next_bits(3), 6);
    assert_eq!(bits.next_bits(3), 4);
    assert_eq!(bits.next_bits(5), 0b10111);
    assert_eq!(bits.next_bits(5), 0b11110);
    assert_eq!(bits.next_bits(5), 0b00101);
}

#[test]
fn test_packet_literal() {
    let mut bits = BITS::from_str("D2FE28");
    let packet = bits.next_packet();
    assert_eq!(
        packet,
        Packet {
            version: 6,
            kind: Kind::Literal(2021)
        }
    )
}


#[test]
fn test_packet_operator() {
    let mut bits = BITS::from_str("38006F45291200");
    let packet = bits.next_packet();
    match packet {
        Packet {kind: Kind::Operator {packets, ..}, ..} => {
            assert_eq!(packets.len(), 2);
            assert_eq!(packets[0], Packet{ version: 6, kind: Kind::Literal(10)});
            assert_eq!(packets[1], Packet{ version: 2, kind: Kind::Literal(20)});
        }
        _ => panic!()
    }
}


#[test]
fn test_sum_versions_1() {
    let mut bits = BITS::from_str("8A004A801A8002F478");
    let packet = bits.next_packet();
    assert_eq!(sum_versions(&packet), 16);
}

#[test]
fn test_sum_versions_2() {
    let mut bits = BITS::from_str("620080001611562C8802118E34");
    let packet = bits.next_packet();
    assert_eq!(sum_versions(&packet), 12);
}

#[test]
fn test_sum_versions_3() {
    let mut bits = BITS::from_str("C0015000016115A2E0802F182340");
    let packet = bits.next_packet();
    assert_eq!(sum_versions(&packet), 23);
}

#[test]
fn test_sum_versions_4() {
    let mut bits = BITS::from_str("A0016C880162017C3686B18A3D4780");
    let packet = bits.next_packet();
    assert_eq!(sum_versions(&packet), 31);
}

#[test]
fn test_packet_value_1() {
    let mut bits = BITS::from_str("9C0141080250320F1802104A08");
    let packet = bits.next_packet();
    assert_eq!(packet.value(), 1);
}
