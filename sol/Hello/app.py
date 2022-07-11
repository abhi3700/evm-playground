'''
		About
		=====
		- After the contract is deployed using truffle
		- interact with contract via sending transaction, via calling states
'''

import json
from web3 import Web3, HTTPProvider
import binascii
from web3.contract import ConciseContract

# truffle development blockchain address in Ganache App
blockchain_address = 'http://127.0.0.1:7545/'

# Client instance to interact with the blockchain
web3 = Web3(HTTPProvider(blockchain_address))

if web3.isConnected():
	# set the default account (so we don't need to set the "from" for every transaction call)
	web3.eth.defaultAccount = web3.eth.accounts[0]		# Using accounts[0] to sign for every transaction

	# path to the compiled contract JSON file
	compiled_contract_path = 'build/contracts/Hello.json'

	# Deployed contract address (see `migrate` command output: `contract address`)
	deployed_contract_address = '0x04C19e10A6831B8C07441Df89123dC1d7598020e'

	with open(compiled_contract_path) as file:
		contract_json = json.load(file)			# load contract info as JSON
		contract_abi = contract_json['abi']		# fetch contract's abi - necessary to call its functions

	# Fetch deployed contract reference
	contract = web3.eth.contract(address= deployed_contract_address, abi= contract_abi)

	# print the contract creator/owner
	print(contract.functions.owner().call())

	# call contract function (this is not persisted to the blockchain)
	tx_hash = contract.functions.setName("abhijit roy").transact()
	print(binascii.hexlify(tx_hash).decode())
	message_name = contract.functions.name().call()
	print(message_name)

	tx_hash = contract.functions.sayHello("abhijit").transact()
	print(binascii.hexlify(tx_hash).decode())
	message_hello = contract.functions.hello().call()
	print(message_hello)


else:
	print(f"Sorry, blockchain network - {blockchain_address} is not running!")