// NOTE: extcodehash used instead of extcodesize to save 300 gas
function isContract(address account) public view returns (bool) {
    bytes32 hash;
    assembly {
        hash := extcodehash(account)
    }
    return (hash != 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470);
}