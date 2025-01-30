struct AlwaysEqual;
struct Color(i32, i32, i32);
struct Point(i32, i32, i32);
struct User {
    active: bool,
    username: String,
    email: String,
    sign_in_count: u64,
}
fn build_user(email: String, username: String) -> User {
    User {
        active: true,
        username,
        email,
        sign_in_count: 1,
    }
}
fn main() {
    let user1 = User {
        email: String::from("example"),
        username: String::from("someusername123"),
        active: true,
        sign_in_count: 1,
    };
    let user2 = User {
        email: String::from("fhajkdfhdahsjkfhdsk"),
        ..user1
    };
}
