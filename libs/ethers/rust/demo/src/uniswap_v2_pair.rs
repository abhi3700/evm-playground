use ethers::{
    contract::abigen,
    core::types::Address,
    providers::{Http, Provider},
};
use eyre::Result;
use std::sync::Arc;

// Generate the type-safe contract bindings by providing the ABI
// definition in human readable format
abigen!(
    IUniswapV2Pair,
    r#"[
        function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast)
    ]"#,
);

// #[tokio::main]
pub(crate) async fn main() -> Result<f64> {
    dotenv::from_path("./.env").expect("Failed in loading the file");
    let rpc_url = std::env::var("MAINNET_RPC_URL").expect("Please check if it's empty");
    let client = Provider::<Http>::try_from(rpc_url)?;
    let client = Arc::new(client);

    // ETH/USDT pair on Uniswap V2
    let address = "0x0d4a11d5EEaaC28EC3F61d100daF4d40471f1852".parse::<Address>()?;
    let pair = IUniswapV2Pair::new(address, Arc::clone(&client));

    // getReserves -> get_reserves
    let (reserve0, reserve1, _timestamp) = pair.get_reserves().call().await?;
    println!("Reserves (ETH, USDT): ({reserve0}, {reserve1})");

    let mid_price = f64::powi(10.0, 18 - 6) * reserve1 as f64 / reserve0 as f64;
    // println!("ETH/USDT price: {mid_price:.2}");
    Ok(mid_price)
}
