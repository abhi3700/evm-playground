//! Example of creating a keystore file from a private key and password, and then reading it back.

use alloy::{primitives::hex, signers::local::LocalSigner};
use eyre::Result;
use rand::thread_rng;
use std::fs::{File, read_to_string};

#[tokio::main]
async fn main() -> Result<()> {
    let cwd = std::env::current_dir()?;
    let keystore_file_path = cwd.join("alice_keystore.json");
    if !keystore_file_path.exists() {
        File::create(&keystore_file_path)?;
    }
    let mut rng = thread_rng();

    // Private key of Alice, the first default Anvil account.
    let private_key = hex!("ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80");

    // Password to encrypt the keystore file with.
    let password = "test";

    // Create a keystore file from the private key of Alice, returning a [Wallet] instance.
    let (wallet, _file_id) = LocalSigner::encrypt_keystore(
        cwd,
        &mut rng,
        private_key,
        password,
        Some("alice_keystore.json"),
    )?;

    println!(
        "Wrote keystore for {} to {:?}",
        wallet.address(),
        keystore_file_path
    );

    // Read the keystore file back.
    let recovered_wallet = LocalSigner::decrypt_keystore(keystore_file_path.clone(), password)?;

    println!(
        "Read keystore from {:?}, recovered address: {}",
        keystore_file_path,
        recovered_wallet.address()
    );

    // Assert that the address of the original key and the recovered key are the same.
    assert_eq!(wallet.address(), recovered_wallet.address());

    // Display the contents of the keystore file.
    let keystore_contents = read_to_string(keystore_file_path)?;

    println!("Keystore file contents: {keystore_contents:?}");

    Ok(())
}
