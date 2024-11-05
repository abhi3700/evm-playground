use ethers::core::k256::ecdsa::SigningKey;
use ethers::utils::hex;
use ethers::{
    prelude::*,
    types::transaction::{eip2718::TypedTransaction, eip2930::AccessList},
    utils::format_units,
};

use std::sync::Arc;

/// Convert Wei to TSSC
// pub(crate) fn wei_to_tssc(bal_wei: U256) -> f64 {
pub(crate) fn wei_to_tssc(bal_wei: U256) -> String {
    // M-1: when need to use the value further
    // let bal_tssc = bal_wei.as_usize() as f64 / 1e18;
    // println!("\nFunder's initial balance (in TSSC): {bal_wei:.18}");

    // M-2: when need to display
    let bal_tssc = format_units(bal_wei, "ether").unwrap();

    bal_tssc
}

/// calculate tx gas cost from `gas_price` & `gas_spent` for a tx
async fn get_gas_cost(
    provider: &Provider<Http>,
    tx_receipt: &TransactionReceipt,
) -> eyre::Result<f64> {
    let gas_price = provider
        .get_transaction(tx_receipt.transaction_hash)
        .await?
        .unwrap()
        .gas_price
        .unwrap();
    // println!("gas price: {} Wei", gas_price);

    let gas_spent = provider
        .get_transaction(tx_receipt.transaction_hash)
        .await?
        .unwrap()
        .gas;
    // println!("gas spent: {}", gas_spent);

    let gas_cost_wei = gas_price.checked_mul(gas_spent).unwrap();
    let gas_cost_tssc = wei_to_tssc_f64(gas_cost_wei);
    // println!("gas cost: {} TSSC", gas_cost_tssc);

    Ok(gas_cost_tssc)
}

/// Convert Wei to TSSC (in String)
pub(crate) fn wei_to_tssc_string(bal_wei: U256) -> String {
    let bal_tssc =
        format_units(U256::from_dec_str(&bal_wei.to_string()).unwrap(), "ether").unwrap();
    bal_tssc
}

/// Convert Wei to TSSC (in f64)
pub(crate) fn wei_to_tssc_f64(bal_wei: U256) -> f64 {
    let eth = format_units(bal_wei, "ether").unwrap();

    eth.parse::<f64>().unwrap()
}
/// Transfer TSSC (chain native token) to single account via eth API call method
/// NOTE: For multiple receiver accounts, we can also use
/// the contract "Fund"'s `transferTsscToMany`
/// One can also leverage the contract "Fund"'s `transferTsscToSingle`
/// function.
pub(crate) async fn transfer_tssc_single(
    client: Arc<Provider<Http>>,
    from_wallet: &Wallet<SigningKey>,
    to: Address,
    amount: U256,
) -> eyre::Result<()> {
    let from = from_wallet.address();

    // let balance_before = provider.get_balance(from, None).await?;
    let nonce1 = client.get_transaction_count(from, None).await?;

    // 1. create a tx
    println!("Creating tx...");
    let typed_tx = TypedTransaction::Eip1559(Eip1559TransactionRequest {
        from: Some(from),
        to: Some(to.into()),
        gas: Some(U256::from(21000)),
        value: Some(U256::from(amount)),
        data: None,
        nonce: Some(nonce1),
        access_list: AccessList(vec![]),
        max_priority_fee_per_gas: None,
        max_fee_per_gas: Some(client.get_gas_price().await?),
        chain_id: Some(client.get_chainid().await?.as_u64().into()),
    });
    // println!("\nTyped tx: {:?}", typed_tx);
    // println!("\nTyped tx hash: {:?}", typed_tx.sighash());

    // 2. sign the tx
    println!("Signing tx...");
    let signature = from_wallet.sign_transaction(&typed_tx).await?;
    // println!("\nSignature: {:?}", signature);

    // 3. serialize the signed tx to get the raw tx
    // RLP encoding has to be done as `Bytes` (ethers::types::Bytes) array
    let rlp_encoded_tx_bytes = typed_tx.rlp_signed(&signature);
    // println!("\nRLP encoded tx bytes: {:?}", rlp_encoded_tx_bytes);

    // 4. send the raw transaction
    println!("Sending raw tx...");
    let tx_receipt = client
        // `eth_sendRawTransaction` is run
        .send_raw_transaction(rlp_encoded_tx_bytes)
        .await
        .expect("Failure in getting pending tx")
        .await
        .expect("Failure in getting Result type")
        .expect("Failure in getting tx receipt");
    println!(
        "Funds sent to \'{}\', which incurred a gas fee of \'{} TSSC\' has a tx hash: \'{:?}\', indexed at #{} in block #{}.",
        to,
        get_gas_cost(&client, &tx_receipt).await?,
        tx_receipt.transaction_hash,
        tx_receipt.transaction_index,
        tx_receipt.block_number.unwrap()
    );

    let nonce2 = client.get_transaction_count(from, None).await?;
    assert!(
        nonce2 > nonce1,
        "Sender's nonce must be incremented after each tx"
    );

    // CLEANUP: remove later (if not required)
    // let balance_after = provider.get_balance(from, None).await?;
    // assert!(balance_after < balance_before);

    // println!("{} has balance before: {balance_before}", from);
    // println!("{} has balance after: {balance_after}", from);

    Ok(())
}

/// transfer eth
pub(crate) async fn transfer_eth(provider: &Provider<Http>) -> eyre::Result<()> {
    let private_key = std::env::var("DEPLOYER_PRIVATE_KEY")
        .expect("Please check if \'DEPLOYER_PRIVATE_KEY\' is empty");
    let private_key_bytes = hex::decode(private_key)?;

    // NOTE: Consider `from` as Signer (in ethers-ts typescript) unlike `to` that is considered as Address (H160).
    let from_wallet = LocalWallet::from_bytes(&private_key_bytes).expect("Wallet creation failed");
    let from = from_wallet.address();
    let to = "0xCa45D2A4993eF89BB881921fF6496C5CbDC78c23".parse::<Address>()?;

    // verify the balance of `from` > 1000
    let current_block_number: U64 = provider.get_block_number().await?;
    let wei_bal = provider
        .get_balance(from, Some(current_block_number.into()))
        .await?;
    assert!(
        wei_bal > U256::from(1000),
        "from\'s wei balance is insufficient"
    );

    let balance_before = provider.get_balance(from, None).await?;
    let nonce1 = provider.get_transaction_count(from, None).await?;

    // 1. create a tx for nodes with `eth_sendTransaction` RPC API method available.
    // NOTE: Normally, it doesn't remain open for public networks, but private/local networks like Anvil.
    // Broadcast it via the eth_sendTransaction API is disabled on pubic nodes (using infura, alchemy).
    // Only enabled on Anvil accounts (local network). Therefore, use `eth_sendRawTransaction` instead.
    // Basically, sign it and then submit as signed raw RLP transaction bytes which is then decoded and then
    // the signature is verified using `recover_signer` method.
    //
    // let tx = TransactionRequest::new().to(to).value(1000).from(from);
    // println!("\nTransfer ETH tx: {}", serde_json::to_string(&tx)?);
    // let tx_receipt = provider.send_transaction(tx, None).await?.await?.unwrap();      // ERROR: `eth_sendTransaction` is not found on public nodes

    let chain_id = provider.get_chainid().await?;

    // 1. create a tx (EIP-1559)
    let typed_tx = TypedTransaction::Eip1559(Eip1559TransactionRequest {
        from: Some(from),
        to: Some(to.into()),
        // ERROR: leading to replacement transaction underpriced in "Sepolia" network ❌, but runs fine in Subspace EVM network ✅
        gas: Some(U256::from(21000)),
        value: Some(U256::from(1000)),
        data: None,
        nonce: Some(nonce1),
        access_list: AccessList(vec![]),
        max_priority_fee_per_gas: None,
        max_fee_per_gas: Some(provider.get_gas_price().await?),
        chain_id: Some(chain_id.as_u64().into()),
    });
    println!("\nTyped tx: {:?}", typed_tx);
    println!("\nTyped tx hash: {:?}", typed_tx.sighash());

    // 2. sign the tx
    let signature = from_wallet.sign_transaction(&typed_tx).await?;
    println!("\nSignature: {:?}", signature);

    // 3. serialize the signed tx to get the raw tx
    // RLP encoding has to be done as `Bytes` (ethers::types::Bytes) array
    let rlp_encoded_tx_bytes = typed_tx.rlp_signed(&signature);
    println!("\nRLP encoded tx bytes: {:?}", rlp_encoded_tx_bytes);

    // 4. send the raw transaction
    let tx_receipt = provider
        // `eth_sendRawTransaction` is run
        .send_raw_transaction(rlp_encoded_tx_bytes)
        .await
        .expect("Failure in raw tx [1]") // ERROR: tx cound not be decoded: couldn't decode RLP components: insufficient remaining input for short string", data: None
        .await
        .expect("Failure in raw tx [2]")
        .expect("Failure in getting tx receipt");
    println!(
        // "Transaction sent with hash: {}",    // 0xdfd6…f80d
        "Transaction sent with hash: {:?}",
        tx_receipt.transaction_hash
    );
    let gas_price = provider
        .get_transaction(tx_receipt.transaction_hash)
        .await?
        .unwrap()
        .gas_price
        .unwrap();
    println!("gas price: {}", gas_price);
    let gas_spent = provider
        .get_transaction(tx_receipt.transaction_hash)
        .await?
        .unwrap()
        .gas;
    println!("gas spent: {}", gas_spent);
    let gas_cost = gas_price
        .checked_mul(gas_spent)
        .unwrap()
        .checked_div(U256::exp10(18))
        .unwrap();
    println!("gas cost: {} TSSC", gas_cost);

    let nonce2 = provider.get_transaction_count(from, None).await?;

    assert!(nonce1 < nonce2);

    let balance_after = provider.get_balance(from, None).await?;
    assert!(balance_after < balance_before);

    println!("{} has balance before: {balance_before}", from);
    println!("{} has balance after: {balance_after}", from);

    Ok(())
}

/// Approach-1: Only one sender account
/// NOTE: LIGHT txs sent as a batch could be signed by single/multiple signer,
/// but no need when calling any storage value.
/// As LIGHT transaction type, multicall particular function
/// let's say `increment` successively done by each new accounts w/o
/// `num_block` cli arg.
#[allow(dead_code)]
pub(crate) async fn multicall_light_txs_1(
    client: Arc<Provider<Http>>,
    multicall_address: Address,
    counter_address: Address,
    signers: Vec<Wallet<SigningKey>>,
) -> eyre::Result<()> {
    // initiate the Multicall instance and add calls one by one in builder style
    let mut multicall: Multicall<Provider<Http>> =
        Multicall::<Provider<Http>>::new(client.clone(), Some(multicall_address))
            .await
            .unwrap();

    // CLEANUP: remove later
    // let mut client_middlewares: Vec<SignerMiddleware<Arc<Provider<Http>>, Wallet<SigningKey>>> =
    // Vec::new();

    // create a middleware client with signature for each signer
    for _ in signers {
        // TODO: how to add signer middleware for signer to sign each call & then add to `multicall`
        // let client_middleware = SignerMiddleware::new(
        //     client.clone(),
        //     signer.with_chain_id(client.get_chainid().await?.as_u64()),
        // );

        // clone the client (if multiple use)
        // let client_middleware = Arc::new(client_middleware);

        // CLEANUP: remove later
        // client_middlewares.push(client);

        // get a contract
        // let counter = Counter::new(counter_address, client_middleware);  // for signer
        let counter = Counter::new(counter_address, client.clone());

        // note that these [`FunctionCall`]s are futures, and need to be `.await`ed to resolve.
        // But we will let `Multicall` to take care of that for us
        let counter_inc_call = counter.increment();
        // let counter_inc_call =
        // counter.method::<_, H256>("increment", false).expect("decoding error");

        // add call to the multicall
        multicall.add_call(counter_inc_call, false);
    }

    // `await`ing the `send` method waits for the transaction to be broadcast, which also
    // returns the transaction hash
    // FIXME: here, the multicall fails due to this error at `.expect("error in....`
    // ```
    // thread 'main' panicked at 'error in sending tx:
    // ContractError(MiddlewareError { e: JsonRpcClientError(JsonRpcError(JsonRpcError { code: -32603, message: "execution fatal: Module(ModuleError { index: 81, error: [0, 0, 0, 0], message: None })", data: None })) })', dtp/src/utils.rs:258:32
    // ```
    let tx_receipt = multicall
        .send()
        .await
        .expect("error in sending tx")
        .await
        .expect("tx dropped")
        .unwrap();
    println!(
        "\'{}\' sent batch txs via \'multicall\', which incurred a gas fee of \'{} TSSC\', has a tx hash: \'{:?}\', indexed at #{} in block #{}.",
        tx_receipt.from,
        get_gas_cost(&client.clone(), &tx_receipt).await?,
        tx_receipt.transaction_hash,
        tx_receipt.transaction_index,
        tx_receipt.block_number.unwrap()
    );

    Ok(())
}

/// Get past events from a block hash
/// Code: https://github.com/gakonst/ethers-rs/commit/da743fc8b29ffeb650c767f622bb19eba2f057b7

/// calculate tx gas cost from `gas_price` & `gas_spent` for a tx
pub(crate) async fn get_gas_cost(
    provider: &Provider<Http>,
    tx_receipt: &TransactionReceipt,
) -> eyre::Result<f64> {
    let gas_price = provider
        .get_transaction(tx_receipt.transaction_hash)
        .await?
        .unwrap()
        .gas_price
        .unwrap();

    let gas_spent = provider
        .get_transaction(tx_receipt.transaction_hash)
        .await?
        .unwrap()
        .gas;

    let gas_cost_wei = gas_price.checked_mul(gas_spent).unwrap();
    let gas_cost_tssc = wei_to_tssc_f64(gas_cost_wei);

    Ok(gas_cost_tssc)
}


/// Generate a new EVM wallet
pub(crate) fn create_new_evm_wallet() -> eyre::Result<Address> {
    let mnemonic = Mnemonic::new(MnemonicType::Words12, Language::English);
    let phrase = mnemonic.phrase();

    // TODO: save the seed phrase into a file
    log::debug!("phrase: {}", phrase);
    assert_eq!(
        phrase.split(" ").count(),
        12,
        "The seed phrase must be 12 words"
    );

    // Generate wallet from the mnemonic
    // Child key at derivation path: m/44'/60'/0'/0/{index}
    let wallet = MnemonicBuilder::<English>::default()
        .phrase(phrase)
        // .index(0u32)?
        // TODO: Use this if your mnemonic is encrypted
        // .password(password)
        .build()?;

    let address = wallet.address();
    // TODO: save this as well or else save the seed phrase with exact derivation path
    let priv_key = format!("0x{}", hex::encode(wallet.signer().to_bytes()));
    let pub_key = format!(
        "0x{}",
        hex::encode(wallet.signer().verifying_key().to_sec1_bytes())
    );

    // log::info!("Mnemonic: {}", mnemonic);
    log::info!("Private key: {}", priv_key);
    log::info!("\nAddress:     {:?}", address);
    log::info!("Public key: {}", pub_key);

    Ok(address)
}
