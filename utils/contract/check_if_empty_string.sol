    // empty string
function _isStringEmpty(string memory s1) private pure returns (bool) {
    if (keccak256(bytes(s1)) == keccak256(bytes(""))) {
        return true;
    } else {
        return false;
    }
}
