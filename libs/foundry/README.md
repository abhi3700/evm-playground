# Foundry

## About

Components:

- [`forge`](https://github.com/foundry-rs/foundry/tree/master/forge): CLI tool to tests, builds, and deploys your smart contracts.
- [`cast`](https://github.com/foundry-rs/foundry/tree/master/cast): to interact with the EVM chain & performing Ethereum RPC calls
- [`anvil`](https://github.com/foundry-rs/foundry/tree/master/anvil): to run a local node like Truffle's Ganache, Hardhat localnode.
- [`chisel`](https://github.com/foundry-rs/foundry/tree/master/chisel): REPL for Solidity. It allows to open a console and interact with the EVM chain (simulated) like `$ npx hardhat console`

## Installation

### via cargo

```sh
# latest
cargo install --git https://github.com/foundry-rs/foundry --profile release --locked forge cast chisel anvil

# specific commit
cargo install --git https://github.com/foundry-rs/foundry \
  --rev <COMMIT> \
  --profile release --locked forge cast chisel anvil
```

### via curl

> [!NOTE]
> Faced some difficulty installing cast, .. tools.

Following are the steps:

1. Install `foundryup`

```console
❯ curl -L https://foundry.paradigm.xyz | zsh
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
100  1765  100  1765    0     0   2236      0 --:--:-- --:--:-- --:--:--  2236
Installing foundryup...
######################################################################## 100.0%

Detected your preferred shell is zsh and added foundryup to PATH. Run 'source /Users/abhi3700/.zshrc' or start a new terminal session to use foundryup.
Then, simply run 'foundryup' to install Foundry.
```

2. Install `foundryup` tools: `forge`, `cast` and `anvil`, `chisel`

```console
❯ foundryup
foundryup: installing foundry (version nightly, tag nightly-92f8951409034fd597ad08a386474af8d2d8868a)
foundryup: downloading latest forge, cast and anvil
######################################################################### 100.0%
foundryup: downloading manpages
######################################################################### 100.0%
foundryup: installed - forge 0.2.0 (92f8951 2022-08-06T00:05:51.433929Z)
foundryup: installed - cast 0.2.0 (92f8951 2022-08-06T00:05:51.433929Z)
foundryup: installed - anvil 0.1.0 (92f8951 2022-08-06T00:05:51.822342Z)
foundryup: done
```

3. Update tools (if already installed)

```console
❯ foundryup
foundryup: installing foundry (version nightly, tag nightly-4a0c8dc4bb068839def6d230ebc38e0354fe7112)
foundryup: downloading latest forge, cast, anvil, and chisel
######################################################################### 100.0%
foundryup: downloading manpages
######################################################################### 100.0%
foundryup: installed - forge 0.2.0 (4a0c8dc 2023-04-15T00:04:40.457382000Z)
foundryup: installed - cast 0.2.0 (4a0c8dc 2023-04-15T00:04:40.457382000Z)
foundryup: installed - anvil 0.1.0 (4a0c8dc 2023-04-15T00:04:41.416294000Z)
foundryup: installed - chisel 0.1.1 (4a0c8dc 2023-04-15T00:04:41.578991000Z)
foundryup: done
```

---

CLI command autocompletions:

```sh
forge completions zsh > /usr/local/share/zsh/site-functions/_forge
cast completions zsh > /usr/local/share/zsh/site-functions/_cast
anvil completions zsh > /usr/local/share/zsh/site-functions/_anvil
```

> Use <kbd>tab</kbd> to view the next option.

[Source](https://book.getfoundry.sh/config/shell-autocompletion?highlight=cast%20completions#zsh).

## Editor

Use VSCode

Additionally, set the `contracts` folder as `src/` & package dependencies as `lib/` for Foundry.

![](../../img/set_folder_name_foundry.png)

---

Format the Solidity files using `$ forge fmt`.

## Getting Started

Refer [this](https://book.getfoundry.sh/getting-started/first-steps)

## Tools

- [forge](./forge.md)
- [cast](./cast.md)
- [anvil](./anvil.md)

## Repositories

I have maintained the work [here](https://github.com/abhi3700/evm_contracts_foundry_1).

- <https://github.com/EricForgy/foundry-hardhat-sample>

## References

- [Smart Contract Development with Foundry | Nader Dabit](https://www.youtube.com/watch?v=uelA2U9TbgM)
- [ForGePT: ChatGPT trained with foundry](https://forgept.apoorv.xyz/)
