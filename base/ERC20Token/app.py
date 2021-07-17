'''
	
	References
	==========
	- https://consensys.net/blog/developers/how-to-send-money-using-python-a-web3-py-tutorial/
'''
import json
from web3 import Web3, HTTPProvider
from input import RINKEBY_API_KEY

# For rinkeby testnet
blockchain_address = f'https://speedy-nodes-nyc.moralis.io/{RINKEBY_API_KEY}/eth/rinkeby'

# Client instance to interact with the blockchain
web3 = Web3(HTTPProvider(blockchain_address))

if web3.isConnected():
	# set the default account (so we don't need to set the "from" for every transaction call)
	web3.eth.defaultAccount = web3.eth.accounts[0]

	# path to the compiled contract JSON file
	compiled_contract_path = '../base/artifacts/contracts/ERC20Token.sol/ERC20Token.json'

	# Deployed contract address (see `migrate` command output: `contract address`)
	deployed_contract_address = '0x8Da5764cbbB70D73D73086b81ba3cD22c8d821aD'

	with open(compiled_contract_path) as file:
		contract_json = json.load(file)			# load contract info as JSON
		contract_abi = contract_json['abi']		# fetch contract's abi - necessary to call its functions

	# Fetch deployed contract reference
	contract = web3.eth.contract(address= deployed_contract_address, abi= contract_abi)

	# call contract function (this is not persisted to the blockchain)
	symbol = contract.functions.symbol().call()
	print(symbol)

else:
	print(f"Sorry, blockchain network - {blockchain_address} is not running!")