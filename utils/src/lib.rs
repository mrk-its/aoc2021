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
