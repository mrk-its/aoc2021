#![no_std]

use core::panic::PanicInfo;

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    write("PANIC!!!\n");
    loop {}
}

extern "C" {
    fn putchar(c: u8);
}

#[inline(never)]
pub fn write(text: &str) {
    text.bytes().for_each(|b| unsafe { putchar(b) });
}
#[inline(never)]
pub fn writeln() {
    write("\n");
}
#[inline(never)]
pub fn write_int<T>(value: T)
where
    T: num::Integer + num::NumCast,
{
    let _10: T = num::cast::cast(10u8).unwrap_or(num::one());
    let (value, digit) = value.div_rem(&_10);
    if value > num::zero() {
        write_int(value);
    }
    unsafe {
        let digit: u8 = num::cast::cast(digit).unwrap_or(0);
        putchar(48 + digit);
    }
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

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        let result = 2 + 2;
        assert_eq!(result, 4);
    }
}
