// NOTE:
// BEFORE EIP-1884: `extcodehash` used instead of `extcodesize` to save 300 gas
// Now as per 13 Jul 2020: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/1802#issuecomment-657668876
// `extcodesize` consumes lesser gas than `extcodehash`
function isContract(address account) public view returns (bool) {
    uint256 size;
    assembly {
        size := extcodesize(account)
    }
    return (size > 0);
}

/// Another way to check is `account.code.length == 0` => address is not a contract.
