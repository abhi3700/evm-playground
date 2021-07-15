function foundContract(address _addr) external pure returns(bool) {
    bool found = false;
    assembly {
        size := extcodesize(_addr)
    }

    if (size > 0) {
        found = true;
    } else {
        found = false;
    }
    return found;
}