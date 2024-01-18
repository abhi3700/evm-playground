# Foundry `cast`

## Commands

#### `$ cast send <contract> <method-sig> <args> --rpc-url <rpc-url> --private-key <private-key-w-0x>`: Send a transaction to a contract

```sh
source .env
cast send 0xA2025B15a1757311bfD68cb14eaeFCc237AF5b43 "transfer(address,uint)" 0x8997F1E62d679Db9713d71E0C0920E93B5f7B4B5 1000000 --private-key $DEPLOYER_PRIVATE_KEY --rpc-url $GOERLI_RPC_URL
```

> Before any command, you need to source `.env` file to set environment variables, if any of them is required.

#### `$ cast call <contract> <method-sig> <args> --rpc-url <rpc-url>`: Call a contract view method

```sh
cast call 0xA2025B15a1757311bfD68cb14eaeFCc237AF5b43 "balanceOf(address)" 0x8997F1E62d679Db9713d71E0C0920E93B5f7B4B5 --rpc-url $GOERLI_RPC_URL
```

#### `$ cast nonce <address> --rpc-url <rpc-url>`: Get a nonce of an address

```sh
cast nonce 0x8997F1E62d679Db9713d71E0C0920E93B5f7B4B5 --rpc-url $GOERLI_RPC_URL
```

#### `$ cast balance <address> --rpc-url <rpc-url>`: Get balance of an address

```sh
❯ cast balance $DEPLOYER_PUBLIC_KEY --rpc-url $GOERLI_RPC_URL
666141520542606020
```

> The balance is in wei.

#### `$ cast wallet new`: Generate a new keypair

```sh
cast wallet new
```

#### `$ cast wallet vanity --starts-with ab11`: Generate a new keypair

```sh
cast wallet vanity --starts-with ab11

Starting to generate vanity address...
Successfully found vanity address in 0 seconds.
Address: 0xAb11D47D3e41233a835bA845A4AdEdFabAB1742F
Private Key: 0x4ab83d67eba63b35a1c7a6efaa5a396a016c2d5e3d589edb53ca8e279a98fb03
```

#### `$ cast wallet vanity --ends-with <HEX>`: Generate a new keypair

```sh
cast wallet vanity --ends-with abad

Starting to generate vanity address...
Successfully found vanity address in 0 seconds.
Address: 0x1633217c6751929f508Ec83a498822662ee9abad
Private Key: 0x59124c1f79877395b09512297269707cda811b49195403f34bb719a34016c56c
```

#### `$ cast wallet address <private-key>`: Get address from a private key

```sh
# Here, you may use your private key with or without `0x` prefix.
$ cast wallet address 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```

#### `$ cast code <contract-address> --rpc-url <rpc-url>`: Get runtime bytecode of a contract

```sh
cast code 0xA2025B15a1757311bfD68cb14eaeFCc237AF5b43 --rpc-url $GOERLI_RPC_URL
```

#### `$ cast codesize <contract-address> --rpc-url <rpc-url>`: Get runtime bytecode size of a contract

```sh
cast codesize 0xA2025B15a1757311bfD68cb14eaeFCc237AF5b43 --rpc-url $GOERLI_RPC_URL
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

#### `$ cast gas-price --rpc-url <rpc-url>`: Get gas price

```sh
$ cast gas-price --rpc-url $GOERLI_RPC_URL
21
```

> The gas price is in wei.

#### `$ cast tx <tx-hash> --rpc-url <rpc-url>`: Get transaction receipt

```sh
❯ cast tx 0x5d0b62108a33db0d5ce052e2e7c371e00b101d2c623926b3909ad27a7e355721 --rpc-url $NOVA_RPC_URL 

blockHash            0x73ae97ff95a0f4dfa71305c576b4c173291eae009f56650c90c87b8afef391b7
blockNumber          570817
from                 0x0370D871f1D4B256E753120221F3Be87A40bd246
gas                  21000
gasPrice             2000000000
hash                 0x5d0b62108a33db0d5ce052e2e7c371e00b101d2c623926b3909ad27a7e355721
input                0x
nonce                267
r                    0x90f49fc4cf352ddf05b3a0e93a6b9fa04c7273b3e8b5a71aeb283157d6119aa2
s                    0x59b2909d96f1674227e528f87bcf549bf5470d36add36515582b8f7fbbedcc21
to                   0x1D1cf575Cc0A8988fA274D36018712dA4632FbDD
transactionIndex     22
v                    0
value                100000000000000000
creates              null
publicKey            0xc578ad038ed7c4c794812d0ef4dce0ff08033cea9bc4d40d3ec158bbfaf1a900d4816173301c0c3f02e3392212a45b3b642dbe932943eb7866b1520a117932c5
raw                  0x02f8768203ea82010b8459682f00849502f900825208941d1cf575cc0a8988fa274d36018712da4632fbdd88016345785d8a000080c080a090f49fc4cf352ddf05b3a0e93a6b9fa04c7273b3e8b5a71aeb283157d6119aa2a059b2909d96f1674227e528f87bcf549bf5470d36add36515582b8f7fbbedcc21
standardV            0
```

#### `$ cast from-wei <amount-in-wei>`: Convert wei to ether

```sh
$ cast from-wei 100000000000000000
0.100000000000000000
```

#### `$ cast to-wei <amount-in-ether>`: Convert ether to wei

```sh
$ cast to-wei 0.100000000000000000
100000000000000000
```
