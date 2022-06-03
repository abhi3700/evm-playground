'''
    
    References
    ==========
    - Here, the transaction call is signed with an address's private key for a public testnet - Rinkeby
'''
import json
from web3 import Web3
from input import *

# For rinkeby testnet
chain_url = f'https://{NETWORK}.infura.io/v3/{INFURA_PROJECT_ID}'

# Client instance to interact with the blockchain
w3 = Web3(Web3.HTTPProvider(chain_url))

if w3.isConnected():
    # set the default account (so we don't need to set the "from" for every transaction call)
    # w3.eth.defaultAccount = w3.eth.accounts[0]        # only for local network

    # path to the compiled contract JSON file
    compiled_contract_path = '../../abi/Hello.json'

    # Deployed contract address
    deployed_contract_address = '0x349B7681e4AbBB7343D952e424fA0e8Ae893E68a'

    with open(compiled_contract_path) as file:
        contract_json = json.load(file)         # load contract info as JSON
        contract_abi = contract_json['abi']     # fetch contract's abi - necessary to call its functions

    # ------------------------------------------------------------------
    # Fetch deployed contract as instance
    contract = w3.eth.contract(address= deployed_contract_address, abi= contract_abi)


    # -------GET------------------------------------------------------
    # read params
    print(contract.functions.admin().call())
    # > 0x3E52edB6f9283dE867fbe65F444CC615CE6F2BcD

    print(contract.functions.helloToUser().call())
    # > 

    # ------SET---------------------------------------------------------
    # call `sayHelloTo` function
    nonce = w3.eth.get_transaction_count(ADDRESS)
    transaction_sayHelloTo = contract.functions.sayHelloTo("Rajeev Kumar").buildTransaction({
                                                    'chainId': 4,
                                                    'gas': 70000,
                                                    # 'maxFeePerGas': w3.toWei('2', 'gwei'),
                                                    # 'maxPriorityFeePerGas': w3.toWei('1', 'gwei'),
                                                    'nonce': nonce, 
                                                    })
    signed_txn_sayHelloTo = w3.eth.account.signTransaction(transaction_sayHelloTo, private_key=PRIVATE_KEY)
    w3.eth.sendRawTransaction(signed_txn_sayHelloTo.rawTransaction)

    # assertion
    # this would fail as the network is so slow that the value is not changed by the time when this line is called.
    print(contract.functions.helloToUser().call() == "Rajeev Kumar")

    # get hash of signed transaction
    print(signed_txn_sayHelloTo.hash)

    # get raw transaction
    print(signed_txn_sayHelloTo.rawTransaction)

    # get r
    print(signed_txn_sayHelloTo.r)

    # get s
    print(signed_txn_sayHelloTo.s)

    # get v
    print(signed_txn_sayHelloTo.v)


else:
    print(f"Sorry, blockchain network - {chain_url} is not running!")