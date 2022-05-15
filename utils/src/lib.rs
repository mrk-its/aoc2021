#![no_std]
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

pub struct BitSet<const N: usize> {
    bits: [u8; N],
}

impl<const N: usize> BitSet<N> {
    pub fn new() -> Self {
        Self { bits: [0; N] }
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
