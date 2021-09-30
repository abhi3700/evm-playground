from web3 import Web3
from decimal import Decimal
import json
from input import *


chain_url = f'https://{NETWORK}.infura.io/v3/{INFURA_PROJECT_ID}'

# Client instance to interact with the blockchain
w3 = Web3(Web3.HTTPProvider(chain_url))

# current block number
print(w3.eth.block_number)

# latest block data
# print(json.dumps(w3.eth.get_block('latest'))['gasLimit'])

# get ETH balance of an account
print(w3.eth.get_balance('0x136eC956EB32364f5016f3f84f56DBfF59c6ead5'))

# # convert from wei to ether
print(w3.fromWei(18452819067960615632, 'ether'))

# # convert from ether to wei
print(w3.toWei(Decimal('3841357.360894980500000001'), 'ether'))

# # get a transaction details
print(w3.eth.get_transaction('0xbdcc83bebe3f6b0c35f284e6a409447ead1552c6726a97808fa635405c55aa2b'))		# return JSON or None

# # read state:
# print(contract_instance.functions.storedValue().call())
# # 42

# # update state:
# tx_hash = contract_instance.functions.updateValue(43).transact()