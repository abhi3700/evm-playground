from web3 import Web3

w3 = Web3(Web3.HTTPProvider('https://ropsten.infura.io/v3/24d441e3175047bfb04c60e8221878c9'))

# current block number
print(w3.eth.block_number)

# latest block data
print(w3.eth.get_block('latest'))