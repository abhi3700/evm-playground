// compare string function
// use the hash approach
function _compareString(string memory s1, string memory s2) private pure returns (bool isEqual) {
    if (keccak256(bytes(s1)) == keccak256(bytes(s2))) {
        isEqual = true;
    } else {
        isEqual = false;
    }
}
