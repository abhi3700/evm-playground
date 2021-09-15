function isContract(address account) public view returns (bool) {
    uint32 size;
    assembly {
        size := extcodesize(account)
    }
    return (size > 0);
}