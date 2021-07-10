from web3 import Web3

web3 = Web3(Web3.HTTPProvider('https://ropsten.infura.io/v3/24d441e3175047bfb04c60e8221878c9'))

# current block number
print(web3.eth.block_number)

# latest block data
print(web3.eth.get_block('latest'))

# get balance of an account
print(web3.eth.get_balance('0x742d35Cc6634C0532925a3b844Bc454e4438f44e'))

# convert from wei to ether
print(web3.fromWei(3841357360894980500000001, 'ether'))

# convert from ether to wei
print(web3.toWei(Decimal('3841357.360894980500000001'), 'ether'))

# get a transaction details
print(web3.eth.get_transaction('0x5c504ed432cb51138bcf09aa5e8a410dd4a1e204ef84bfed1be16dfba1b22060'))		# return JSON or None

# read state:
print(contract_instance.functions.storedValue().call())
# 42

# update state:
tx_hash = contract_instance.functions.updateValue(43).transact()