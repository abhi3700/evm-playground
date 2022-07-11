# Fe

A NEW SC language for EVM Blockchains.

## About

## Installation

### Build from Source

> Although this method is very naive, so it might throw error during the `cargo build ...`. So, download the binary instead ([shown](https://github.com/abhi3700/evm_playground/blob/main/fe/README.md#download-binary-recommended) below).

1. Create `fe` compiler

```console
❯ git clone https://github.com/ethereum/fe.git
❯ cd fe
❯ cargo build
❯ cargo build --features solc-backend
```

Now, the `fe` compiler is found at this location '`fe/target/debug/`'

> `cargo build` gives `fe` binary which creates ABI file.
> `cargo build --features solc-backend` gives `fe` binary which creates both ABI (`.json`) & binary (`.bin`) files.

> For more details, follow [Build doc](https://github.com/ethereum/fe/blob/master/docs/src/development/build.md)

Now, add into `.zprofile` file via `❯ code ~/.zprofile` (open using VSCode).

```bash
# Fe compiler for EVM SC
alias fe="~/F/coding/github_repos/fe/target/debug/fe"
```

```bash
❯ source ~/.zprofile
```

Check `fe` is installed:

```bash
❯ fe --version                                                                ⏎
fe 0.19.1-alpha
```

### Download Binary [RECOMMENDED]

Download the binary `fe_mac` from [here](https://github.com/ethereum/fe/releases) into home directory i.e. `~`.

And then change the permission for execution of the file.

Now, add into `.zprofile` file via `❯ code ~/.zprofile` (open using VSCode).

```bash
# Fe compiler for EVM SC
alias fe="~/fe_mac"
```

```bash
❯ source ~/.zprofile
```

Check `fe` is installed:

```bash
❯ fe --version                                                                ⏎
fe 0.19.1-alpha
```

## Quickstart

- Create a project: `$ fe new hello`
- Build the project inside the project folder: `$ fe build ./`
  - It creates an output folder which contains `abi`, `bin` files.
  - To overwrite use `$ fe build ./ --overwrite`

## References

- [Github](https://github.com/ethereum/fe)
- [Documentation](https://fe-lang.org/)
- [Quickstart](https://fe-lang.org/docs/quickstart/index.html)
- [Run with Hardhat](https://github.com/Developer-DAO/hardhat-fe)
