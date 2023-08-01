# Foundry `cast`

## Commands

#### `$ cast send <contract> <method-sig> <args> --rpc-url <rpc-url> --private-key <private-key-w-0x>`: Send a transaction to a contract

```sh
$ source .env
$ cast send 0xA2025B15a1757311bfD68cb14eaeFCc237AF5b43 "transfer(address,uint)" 0x8997F1E62d679Db9713d71E0C0920E93B5f7B4B5 1000000 --private-key $DEPLOYER_PRIVATE_KEY --rpc-url $GOERLI_RPC_URL
```

> Before any command, you need to source `.env` file to set environment variables, if any of them is required.

#### `$ cast call <contract> <method-sig> <args> --rpc-url <rpc-url>`: Call a contract view method

```sh
$ cast call 0xA2025B15a1757311bfD68cb14eaeFCc237AF5b43 "balanceOf(address)" 0x8997F1E62d679Db9713d71E0C0920E93B5f7B4B5 --rpc-url $GOERLI_RPC_URL
```

#### `$ cast nonce <address> --rpc-url <rpc-url>`: Get a nonce of an address

```sh
$ cast nonce --rpc-url $GOERLI_RPC_URL 0x8997F1E62d679Db9713d71E0C0920E93B5f7B4B5
```

#### `$ cast wallet new`: Generate a new keypair.

```sh
$ cast wallet new
```

#### `$ cast wallet address <private-key>`: Get address from a private key.

```sh
# Here, you may use your private key with or without `0x` prefix.
$ cast wallet address 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```

#### `$ cast code <contract-address> --rpc-url <rpc-url>`: Get runtime bytecode of a contract.

```sh
$ cast code --rpc-url $GOERLI_RPC_URL 0xA2025B15a1757311bfD68cb14eaeFCc237AF5b43
```

#### `$ cast codesize <contract-address> --rpc-url <rpc-url>`: Get runtime bytecode size of a contract.

```sh
$ cast codesize --rpc-url $GOERLI_RPC_URL 0xA2025B15a1757311bfD68cb14eaeFCc237AF5b43
```

#### `$ cast compute-address --nonce <nonce> <address>`: Compute the contract address from a given nonce and deployer address

```sh
# Here, we compute the nonce of the deployer address and then compute the contract address from (nonce, deployer_address).
# NOTE: The nonce is calculate with $() and then passed to the command.
$ cast compute-address --nonce $(cast nonce 0x0370D871f1D4B256E753120221F3Be87A40bd246 --rpc-url $GOERLI_RPC_URL) 0x0370D871f1D4B256E753120221F3Be87A40bd246
```

#### `$ cast create2 -d <deployer-address> -s <starts-with>`: Generate a deterministic contract address using CREATE2

```sh
$ cast create2 -d 0x0370D871f1D4B256E753120221F3Be87A40bd246 -s 5F
Starting to generate deterministic contract address...
Successfully found contract address in 0 seconds.
Address: 0x5FbDfBd703aa1fB27a1a221dC4377e5d4Dc21Ad5
Salt: 78701361982984830578193236588942944668249669402332830498138071945150086690932
```
