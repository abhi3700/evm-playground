# Fe

A NEW SC language for EVM Blockchains.

## About

## Install

```sh
brew install fe-lang/tap/fe
```

```sh
$ fe
fe 0.26.0
The Fe Developers <snakecharmers@ethereum.org>
An implementation of the Fe smart contract language

USAGE:
    fe <SUBCOMMAND>

OPTIONS:
    -h, --help       Print help information
    -V, --version    Print version information

SUBCOMMANDS:
    build     Build the current project
    check     Analyze the current project and report errors, but don't build artifacts
    help      Print this message or the help of the given subcommand(s)
    new       Create new fe project
    test      Execute tests in the current project
    verify    Verify any onchain contract against local available source code.
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
