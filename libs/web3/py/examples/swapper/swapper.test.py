'''
Swapper SC repo:
================
- Upside/republic-crypto/nft-bundler

Here, the SC is deployed on Rinkeby testnet & the function used for running test is: `claim`
'''

import json
from web3 import Web3
from input import *

# For rinkeby testnet
chain_url = f'https://{NETWORK}.infura.io/v3/{INFURA_PROJECT_ID}'

# Client instance to interact with a blockchain (public - testnet, mainnet)
w3 = Web3(Web3.HTTPProvider(chain_url))

# if web3 is connected
if w3.isConnected():

    # path to the compiled contract JSON file
    compiled_contract_path = '../artifacts/contracts/Swapper.sol/Swapper.json'

    # Deployed contract address
    deployed_contract_address = '0x03BD7f8981819C47cf1c404Cec827d7f239E4Ef3'

    # caller address
    caller_address = '0x0370D871f1D4B256E753120221F3Be87A40bd246'

    with open(compiled_contract_path, 'r') as file:
        contract_json = json.load(file)         # load contract info as JSON
        # fetch contract's abi - necessary to call its functions
        contract_abi = contract_json['abi']

    # ------------------------------------------------------------------
    # Fetch deployed contract as instance
    contract = w3.eth.contract(
        address=deployed_contract_address, abi=contract_abi)

    # -------GET------------------------------------------------------
    # read params
    print(contract.functions.snapshotId().call())
    # >

    # -------SET---------------------------------------------------------
    # find function by name
    print(contract.get_function_by_name('claim'))

    # estimate gas for function
    # gas_est = contract.functions.claim().estimateGas()
    # print(gas_est)

    # call `claim` function
    nonce = w3.eth.get_transaction_count(ADDRESS)
    print(f'Nonce: {nonce}')

    txn = contract.functions.claim().buildTransaction({
        'chainId': w3.eth.chainId,
        'gas': 70000,
        'maxFeePerGas': w3.toWei('2', 'gwei'),
        'maxPriorityFeePerGas': w3.toWei('1', 'gwei'),
        'nonce': nonce,
    })
    signed_txn = w3.eth.account.sign_transaction(
        txn,
        private_key=PRIVATE_KEY
    )
    send_txn = w3.eth.sendRawTransaction(signed_txn.rawTransaction)

    # get hash of signed transaction
    print(signed_txn.hash)

    # get raw transaction
    print(signed_txn.rawTransaction)

    # # get r
    # print(signed_txn.r)

    # # get s
    # print(signed_txn.s)

    # # get v
    # print(signed_txn.v)

    # get hash of sent transaction (if approved)
    print(f'Transaction hash: {send_txn.hex()}')

# when web3 is NOT connected
else:
    print(f"Sorry, blockchain network - {chain_url} is not running!")
