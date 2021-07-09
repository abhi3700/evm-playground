# Hello

## Compile
```console
$ truffle compile

Compiling your contracts...
===========================
> Compiling ./contracts/Hello.sol
> Artifacts written to /mnt/f/Coding/github_repos/ethio_playground/base/Hello/build/contracts
> Compiled successfully using:
   - solc: 0.8.6+commit.11564f7e.Emscripten.clang
```

## Deploy
* develop
```console
$ truffle develop
Connected to existing Truffle Develop session at http://127.0.0.1:9545/

truffle(develop)>
```
* migrate
```console
truffle(develop)> migrate

Compiling your contracts...
===========================
> Everything is up to date, there is nothing to compile.



Starting migrations...
======================
> Network name:    'develop'
> Network id:      5777
> Block gas limit: 6721975 (0x6691b7)


2_deploy_contract.js
====================

   Deploying 'Hello'
   -----------------
   > transaction hash:    0x876977cc4fb7af1e98cc5a64273c437e1223997b42fe8754e096128add50257f
   > Blocks: 0            Seconds: 0
   > contract address:    0xaB972Cc60eCA1E237eD6479b622A8a1ae1E46923
   > block number:        3
   > block timestamp:     1625825997
   > account:             0xf747ad5656bd26d03d52EaDf8bc42AA10e821412
   > balance:             99.99862449
   > gas used:            396388 (0x60c64)
   > gas price:           2 gwei
   > value sent:          0 ETH
   > total cost:          0.000792776 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:         0.000792776 ETH


Summary
=======
> Total deployments:   1
> Final cost:          0.000792776 ETH


- Blocks: 0            Seconds: 0
- Saving migration to chain.

```

## Testing
### Using `Web3.py`


