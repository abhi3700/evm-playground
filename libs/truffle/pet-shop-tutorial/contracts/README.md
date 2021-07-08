# Pet Shop

## About
* 

## Functions
* `adopt`
* `getAdopters`

## Storage
* `adopters`

## Compile
```console
$ truffle compile

Compiling your contracts...
===========================
> Compiling ./contracts/Adoption.sol
> Compiling ./contracts/Migrations.sol
> Artifacts written to /mnt/f/Coding/github_repos/ethio_playground/libs/truffle/pet-shop-tutorial/build/contracts
> Compiled successfully using:
   - solc: 0.8.6+commit.11564f7e.Emscripten.clang
```

## Deploy
```console
$ truffle migrate

Compiling your contracts...
===========================
> Everything is up to date, there is nothing to compile.



Starting migrations...
======================
> Network name:    'development'
> Network id:      5777
> Block gas limit: 6721975 (0x6691b7)


1_initial_migration.js
======================

   Deploying 'Migrations'
   ----------------------
   > transaction hash:    0xde5f5f649c11761ae24c4cd21fdae21ceadc52ff44f528d335dc9d1936561ce4
   > Blocks: 0            Seconds: 0
   > contract address:    0x348CD3211D2c4c50872E9D01a51cEeE89AB86548
   > block number:        1
   > block timestamp:     1625745385
   > account:             0xef92fAA501c2B7F84763066fE382DfC455A2Bf82
   > balance:             99.99692156
   > gas used:            153922 (0x25942)
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00307844 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:          0.00307844 ETH


2_deploy_contracts.js
=====================

   Deploying 'Adoption'
   --------------------
   > transaction hash:    0x292699ec63e7c1bdc2534c609a057e291492030281c728f15fc93d16588d10a9
   > Blocks: 0            Seconds: 0
   > contract address:    0xc27d7b07cE4d542b82916f9152c77F0c292A8865
   > block number:        3
   > block timestamp:     1625745387
   > account:             0xef92fAA501c2B7F84763066fE382DfC455A2Bf82
   > balance:             99.99237242
   > gas used:            185167 (0x2d34f)
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00370334 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:          0.00370334 ETH


Summary
=======
> Total deployments:   2
> Final cost:          0.00678178 ETH
```

## Testing
* [Testing the smart contract using Solidity](https://www.trufflesuite.com/tutorial#testing-the-smart-contract-using-solidity)
   - `TestAdoption.sol` has functions:
      + `testUserCanAdoptPet()`
      + `testGetAdopterAddressByPetId()`
      + `testGetAdopterAddressByPetIdInArray()`
* testing
```console
$ truffle test
Using network 'development'.


Compiling your contracts...
===========================
> Compiling ./test/TestAdoption.sol
> Artifacts written to /tmp/test--16100-tnIw8zCigZul
> Compiled successfully using:
   - solc: 0.8.6+commit.11564f7e.Emscripten.clang



  TestAdoption
    ✓ testUserCanAdoptPet (367ms)
    ✓ testGetAdopterAddressByPetId (297ms)
    ✓ testGetAdopterAddressByPetIdInArray (294ms)


  3 passing (20s)
```