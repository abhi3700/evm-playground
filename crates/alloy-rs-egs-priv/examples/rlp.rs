//! RLP

use alloy_rlp::{self, RlpDecodable, RlpEncodable, encode};

#[derive(RlpEncodable, RlpDecodable)]
struct Foo {
    name: String,
    chains: Vec<String>,
}

fn main() {
    let rlp_encode = encode("he".as_bytes());
    println!("he -> RLP encoded: {}", alloy::hex::encode(rlp_encode));

    let foo = Foo {
        name: "UniFi".to_owned(),
        chains: vec!["Ethereum".to_owned(), "Polygon".to_owned()],
    };
    let foo_rlp_encoded = encode(foo);
    println!(
        "Foo -> RLP encoded: {}",
        alloy::hex::encode(foo_rlp_encoded)
    );
}
