#![no_std]

use core::panic::PanicInfo;

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    write("PANIC!!!");
    loop {}
}

extern "C" {
    fn putchar(c: u8);
}

pub fn write(text: &str) {
    text.bytes().for_each(|b| unsafe { putchar(b) });
}
pub fn writeln() {
    write("\n");
}
pub fn write_int<T>(value: T) where T: num::Integer + num::NumCast {
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


#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        let result = 2 + 2;
        assert_eq!(result, 4);
    }
}
