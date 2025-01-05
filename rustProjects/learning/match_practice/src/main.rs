#[derive(Debug)]
enum UsState {
    Alabama,
    Alaska,
    //etc.
}
enum Coin {
    Penny,
    Nickel,
    Dime,
    Quarter(UsState),
}
fn value_in_cents(coin: Coin) -> u8 {
    match coin {
        Coin::Penny => {
            println!("LuckyPenny");
            1
        }
        Coin::Nickel => 5,
        Coin::Dime => 10,
        Coin::Quarter(state) => {
            println!("State Quarter from {state:?}!");
            25
        }
    }
}
fn main() {}
