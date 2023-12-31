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

/// Another way to check is `account.code.length > 0` => address is a contract.
/// NOTE: This might consume more gas
function isContract(address account) internal view returns (bool) {
    // This method relies on extcodesize/address.code.length, which returns 0
    // for contracts in construction, since the code is only stored at the end
    // of the constructor execution.

    return account.code.length > 0;
}
