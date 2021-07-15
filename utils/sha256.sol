// sha256(bytes memory) returns (bytes32)
function callSha256() public pure returns(bytes32 result){
    return sha256("ABC");
}

/*
    - check with this: https://emn178.github.io/online-tools/sha256.html
    E.g:
        - 0: bytes32: result 0xb5d4045c3f466fa91fe2cc6abe79232a1a57cdf104f7a26e716e0a1e2789df78
*/