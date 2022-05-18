#![no_std]
#![feature(generic_const_exprs)]

use core::panic::PanicInfo;
use ufmt_stdio::*;

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    println!("PANIC!!!");
    loop {}
}

#[macro_export]
macro_rules! entry {
    ($path:path) => {
        #[start]
        fn _main(_argc: isize, _argv: *const *const u8) -> isize {
            // type check the given path
            let f: fn() -> () = $path;
            f();

            #[cfg(target_vendor = "a800xl")]
            loop {}

            #[cfg(not(target_vendor = "a800xl"))]
            0
        }
    };
}

#[macro_export]
macro_rules! iter_lines {
    ($name:expr) => {
        include_bytes!($name).split(|c| *c == b'\n')
    };
}

pub fn to_str(data: &[u8]) -> &str {
    unsafe { core::str::from_utf8_unchecked(data) }
}

pub trait SimpleHash {
    fn hash(&self) -> usize {
        0
    }
}

pub struct BitSet<const N: usize>
where
    [(); (N + 7) / 8]:,
{
    bits: [u8; (N + 7) / 8],
}

impl<const N: usize> BitSet<N>
where
    [(); (N + 7) / 8]:,
{
    pub fn new() -> Self {
        Self {
            bits: [0; (N + 7) / 8],
        }
    }
    pub fn contains(&self, index: usize) -> bool {
        let offs = index / 8;
        let bit_offs = index & 7;
        return (self.bits[offs] >> bit_offs) & 1 > 0;
    }
    pub fn insert(&mut self, index: usize) {
        let offs = index / 8;
        let bit_offs = index & 7;
        self.bits[offs] |= 1 << bit_offs;
    }
}

pub struct SimpleMap<const N: usize, K, V>
where
    K: Copy + Eq + SimpleHash,
    V: Copy,
{
    data: [Option<(K, V)>; N],
}

impl<const N: usize, K, V> SimpleMap<N, K, V>
where
    K: Copy + Eq + SimpleHash,
    V: Copy,
{
    pub fn new() -> Self {
        Self {
            data: [Default::default(); N],
        }
    }

    pub fn insert(&mut self, key: K, value: V) {
        let mut index = key.hash() % N;
        let start_index = index;
        loop {
            match &self.data[index] {
                Some((k, v)) => {
                    if key == *k {
                        self.data[index] = Some((*k, *v));
                        return;
                    }
                }
                None => {
                    self.data[index] = Some((key, value));
                    return;
                }
            }
            index = (index + 1) % N;
            if index == start_index {
                panic!("no free space");
            }
        }
    }
    pub fn contains(&self, key: &K) -> bool {
        let mut index = key.hash() % N;
        let start_index = index;
        loop {
            match &self.data[index] {
                Some((k, _)) => {
                    if *key == *k {
                        return true;
                    }
                }
                None => {
                    return false;
                }
            }
            index = (index + 1) % N;
            if index == start_index {
                return false;
            }
        }
    }
    pub fn iter_keys(&self) -> impl Iterator<Item = &K> {
        self.data
            .iter()
            .filter(|k| k.is_some())
            .map(|k| &k.as_ref().unwrap().0)
    }
}
pub struct SimpleSet<const N: usize, K>(SimpleMap<N, K, ()>)
where
    K: Copy + Eq + SimpleHash;

impl<const N: usize, K> SimpleSet<N, K>
where
    K: Copy + Eq + SimpleHash,
{
    pub fn new() -> Self {
        Self(SimpleMap::new())
    }
    pub fn insert(&mut self, key: K) {
        self.0.insert(key, ());
    }
    pub fn contains(&self, key: &K) -> bool {
        self.0.contains(key)
    }
    pub fn iter(&self) -> impl Iterator<Item = &K> {
        self.0.iter_keys()
    }
}
