// keccak256(bytes memory) returns (bytes32)
function callKeccak256(string memory name) public pure returns (bytes32 result) {
    return keccak256(bytes(name));
}

/*
    - check with this: https://emn178.github.io/online-tools/keccak_256.html
    E.g:
        - 0: bytes32: result 0xe1629b9dda060bb30c7908346f6af189c16773fa148d3366701fbaa35d54f3c8
*/
