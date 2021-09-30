# Web3.py

## Installation
* `pip install web3`

## Concepts
* All of the smart contract functions are listed under the `contract.functions` namespace within the assigned Web3 contract. For example, we can call `contract.functions.myFunction()` if the contract implements `myFunction()`.
```py
# For ERC20 token
print(contract.functions.name().call())
# > OMG Token
```

## Troubleshooting
* Error related to MS Visual C++ 14.0 or greater is missing:
```
error: Microsoft Visual C++ 14.0 or greater is required. Get it with "Microsoft C++ Build Tools": https://visualstudio.microsoft.com/visual-cpp-build-tools/
```

	- solution: install libs using pip: `conda install libpython m2w64-toolchain -c msys2` as __administrator__ in command prompt.

## References
* [Intro to Web3.py · Ethereum For Python Developers](https://www.dappuniversity.com/articles/web3-py-intro)
* [Ethereum Smart Contracts in Python: a comprehensive(ish) guide](https://hackernoon.com/ethereum-smart-contracts-in-python-a-comprehensive-ish-guide-771b03990988)
