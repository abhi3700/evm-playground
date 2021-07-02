// mapping(address => uint) balances;

uint i = 0;

// abi.encodePacker() is the method
i_bytes = abi.encodePacked(i);

// check if key exists
if (abi.encodePacked(balances[addr]).length > 0) {
	delete balances[addr];
}