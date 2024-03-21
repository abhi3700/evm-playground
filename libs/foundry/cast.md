# Foundry `cast`

## Commands

| NOTE | Wherever, you found `$...` in the command, you need to run `$ source .env` first i.e. import your env vars.
|--|--|

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

#### `cast chain-id --rpc-url <RPC_URL>`: Get chain id

```sh
$ cast chain-id --rpc-url $SEPOLIA_RPC_URL
11155111
```

#### `cast --to-bytes <VALUE_IN_ANY_BYTES>`: Convert to bytes32 using zero padding

```sh
$ cast to-bytes32 0xc81dcb9afa23cb8483f31b0252a00c93cfc5ac9e                                                                ⏎
0xc81dcb9afa23cb8483f31b0252a00c93cfc5ac9e000000000000000000000000
```

#### `cast format-bytes32-string <STRING_VALUE>`: Convert string to bytes32

```sh
$ cast format-bytes32-string 'Abhijit is a good boy.'
0x416268696a6974206973206120676f6f6420626f792e00000000000000000000
```

> No matter you use single/double quotes.

#### `cast client --rpc-url <RPC_URL>`: Get client version

```sh
$ cast client --rpc-url $SEPOLIA_RPC_URL
Geth/v1.13.14-omnibus-9653f48e/linux-amd64/go1.21.6
```

This is the client version of the node connected to.

#### `cast receipt <TRANSACTION_HASH> logs --rpc-url <RPC_URL>`: Get the transaction receipt for a transaction

This is a tx sent for contract deployment with 2 constructor params:

<details><summary>Details:</summary>

```sh
$ cast receipt 0xc9399c465bbaa846a11cfa08bb8a1d282e937d255d1748ef66442baf32201fca logs --rpc-url $SEPOLIA_RPC_URL 
[

    address: 0xC81dcb9AfA23Cb8483f31b0252a00C93cfc5aC9e
    blockHash: 0xac6a8fd10aa73ee6a158a563613d3bded6bff7c30d30f9bbe311ee42c3e17193
    blockNumber: 5525138
    data: 0x
    logIndex: 50
    removed: false
    topics: [
        0x8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e0
        0x0000000000000000000000000000000000000000000000000000000000000000
        0x0000000000000000000000000370d871f1d4b256e753120221f3be87a40bd246
    ]
    transactionHash: 0xc9399c465bbaa846a11cfa08bb8a1d282e937d255d1748ef66442baf32201fca
    transactionIndex: 71

    address: 0x6EDCE65403992e310A62460808c4b910D972f10f
    blockHash: 0xac6a8fd10aa73ee6a158a563613d3bded6bff7c30d30f9bbe311ee42c3e17193
    blockNumber: 5525138
    data: 0x000000000000000000000000c81dcb9afa23cb8483f31b0252a00c93cfc5ac9e0000000000000000000000000370d871f1d4b256e753120221f3be87a40bd246
    logIndex: 51
    removed: false
    topics: [
        0x6ee10e9ed4d6ce9742703a498707862f4b00f1396a87195eb93267b3d7983981
    ]
    transactionHash: 0xc9399c465bbaa846a11cfa08bb8a1d282e937d255d1748ef66442baf32201fca
    transactionIndex: 71
]
```

Here, there are 2 actions/logs in this tx, so let's decode the topics using `$ cast 4byte`

Now, let's take the 1st log in the tx.

> Only considered data & topics.

```
data: 0x
topics: [
    0x8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e0
    0x0000000000000000000000000000000000000000000000000000000000000000
    0x0000000000000000000000000370d871f1d4b256e753120221f3be87a40bd246
]
```

- 1st topic contains function selector (0x..):

```sh
$ cast 4byte 0x8be0079c
OwnershipTransferred(address,address)
```

To get the 1st event log, we need to take `topics`+`data` i.e. 0x`4 bytes of 1st topic` + `2nd topic` + `3rd topic` + `data`

```sh
cast 4byte-decode 0x8be0079c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000370d871f1d4b256e753120221f3be87a40bd2460000000000000000000000000000000000000000000000000000000000000000

1) "OwnershipTransferred(address,address)"
0x0000000000000000000000000000000000000000
0x0370D871f1D4B256E753120221F3Be87A40bd246
```

---

Now, let's take the 2nd log in the tx.

```sh
data: 0x000000000000000000000000c81dcb9afa23cb8483f31b0252a00c93cfc5ac9e0000000000000000000000000370d871f1d4b256e753120221f3be87a40bd246
topics: [
    0x6ee10e9ed4d6ce9742703a498707862f4b00f1396a87195eb93267b3d7983981
]
```

let's directly do `4byte-decode`:

```sh
cast 4byte-decode 0x6ee10e9e000000000000000000000000c81dcb9afa23cb8483f31b0252a00c93cfc5ac9e0000000000000000000000000370d871f1d4b256e753120221f3be87a40bd246
```

OR

consider the 1st topic as event signature & decode:

```sh
$ cast 4byte-event 0x6ee10e9ed4d6ce9742703a498707862f4b00f1396a87195eb93267b3d7983981
DelegateSet(address,address)
```

It should be like:

```sh
2) DelegateSet (address sender, address delegate)
0xc81dcb9afa23cb8483f31b0252a00c93cfc5ac9e
0x0370d871f1d4b256e753120221f3be87a40bd246
```

You can verify these 2 event logs from [url](https://sepolia.etherscan.io/tx/0xc9399c465bbaa846a11cfa08bb8a1d282e937d255d1748ef66442baf32201fca#eventlog)

</details>

---

This is a tx sent for calling a function with signature: `send(uint32,string,bytes)`:

<details><summary>View on terminal:</summary>

```sh
$ cast receipt 0xbd40578f79efda941d381fa33e70261b960af1b8c9e5a9b673e44a5a7a82c7be logs --rpc-url $SEPOLIA_RPC_URL 
[

    address: 0xcc1ae8Cf5D3904Cef3360A9532B477529b177cCE
    blockHash: 0x916bd1d22786d43f055fa2f54f2736383f0e1a6a1431edf4e07502fa55528167
    blockNumber: 5530538
    data: 0x000000000000000000000000718b92b5cb0a5552039b593faf724d182a881eda0000000000000000000000000000000000000000000000000000381c8a97d749
    logIndex: 48
    removed: false
    topics: [
        0x61ed099e74a97a1d7f8bb0952a88ca8b7b8ebd00c126ea04671f92a81213318a
    ]
    transactionHash: 0xbd40578f79efda941d381fa33e70261b960af1b8c9e5a9b673e44a5a7a82c7be
    transactionIndex: 55

    address: 0xcc1ae8Cf5D3904Cef3360A9532B477529b177cCE
    blockHash: 0x916bd1d22786d43f055fa2f54f2736383f0e1a6a1431edf4e07502fa55528167
    blockNumber: 5530538
    data: 0x000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000000010000000000000000000000008eebf8b423b73bfca51a1db4b7354aa0bfca919300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000002d8b300d357
    logIndex: 49
    removed: false
    topics: [
        0x07ea52d82345d6e838192107d8fd7123d9c2ec8e916cd0aad13fd2b60db24644
    ]
    transactionHash: 0xbd40578f79efda941d381fa33e70261b960af1b8c9e5a9b673e44a5a7a82c7be
    transactionIndex: 55

    address: 0x6EDCE65403992e310A62460808c4b910D972f10f
    blockHash: 0x916bd1d22786d43f055fa2f54f2736383f0e1a6a1431edf4e07502fa55528167
    blockNumber: 5530538
    data: 0x00000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000160000000000000000000000000cc1ae8cf5d3904cef3360a9532b477529b177cce00000000000000000000000000000000000000000000000000000000000000d101000000000000000100009ce1000000000000000000000000c81dcb9afa23cb8483f31b0252a00c93cfc5ac9e00009cad6edce65403992e310a62460808c4b910d972f10f0000000000000000000000009cc7135c113d207a5f0816e65335198eb5a1d8cfc440a5177d6012562f76850200000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000015416268696a6974206973206120676f6f6420626f790000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001600030100110100000000000000000000000000030d4000000000000000000000
    logIndex: 50
    removed: false
    topics: [
        0x1ab700d4ced0c005b164c0f789fd09fcbb0156d4c2041b8a3bfbcd961cd1567f
    ]
    transactionHash: 0xbd40578f79efda941d381fa33e70261b960af1b8c9e5a9b673e44a5a7a82c7be
    transactionIndex: 55
]
```

</details>
