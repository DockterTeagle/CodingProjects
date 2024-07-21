use rand::Rng;
use std::io;
fn main() {
    let secret_number = rand::thread_rng().gen_range(1..=100);
    println!("Guess the Number");
    println!("Please input your guess");
    let mut guess = String::new();
    io::stdin()
        .read_line(&mut guess)
        .expect("Failed to read line");
    println!("you guessed {guess}")
}