# Foundry `anvil`

## Commands

#### `$ anvil`: Start a local node

```sh
anvil
```

#### `$ anvil --fork-url $NOVA_RPC_URL`: Fork a blockchain from another node to local node

- This would fork a blockchain onto a localhost. It helps to view the transaction details before sending to the real network. You could also use `forge script` without `--broadcast` flag to simulate. But, the gas-price is not like that of real network. It's always better to fork instead.
- You could fork so many different blockchains (Sepolia, Goerli, Mumbai) to try onto, if you don't have enough gas.

#### `$ anvil --gas-price <>`: Start a local node with custom gas price (in wei)

```sh
anvil --gas-price 3000000020
```

#### `$ anvil --gas-limit <value-per-block> --gas-price <value-in-wei>`: Start a local node with custom gas limit (per block) and gas price (in wei)

```sh
anvil --gas-limit 60000000 --gas-price 3000000020
```

## Visualize

<https://app.tryethernal.com/overview> | FREE

- In the settings page, you can change the network to local forked RPC node url: `ws://localhost:8545`, You can spin up a local node using `anvil` with `anvil -f $SEPOLIA_RPC_URL -p 8545`
