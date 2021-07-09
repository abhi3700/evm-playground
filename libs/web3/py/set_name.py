import json
from web3 import Web3, HTTPProvider

# truffle development blockchain address
blockchain_address = 'http://127.0.0.1:7545/'

# Client instance to interact with the blockchain
web3 = Web3(HTTPProvider(blockchain_address))

if web3.isConnected():
	# set the default account (so we don't need to set the "from" for every transaction call)
	web3.eth.defaultAccount = web3.eth.accounts[0]

	# path to the compiled contract JSON file
	compiled_contract_path = 'build/contracts/Hello.json'

	# Deployed contract address (see `migrate` command output: `contract address`)
	deployed_contract_address = '0x8ba695C11509e00680972E2865E3F0c87ebF6803'

	with open(compiled_contract_path) as file:
		contract_json = json.load(file)			# load contract info as JSON
		contract_abi = contract_json['abi']		# fetch contract's abi - necessary to call its functions

	# Fetch deployed contract reference
	contract = web3.eth.contract(address= deployed_contract_address, abi= contract_abi)

	# call contract function (this is not persisted to the blockchain)
	contract.functions.setName("abhijit roy").transact()
	message_name = contract.functions.getName().call()
	print(message_name)

	contract.functions.sayHello("abhijit").transact()
	message_hello = contract.functions.hello().call()
	print(message_hello)

else:
	print(f"Sorry, blockchain network - {blockchain_address} is not running!")