// There is a function which can be used for comparison of 2 strings

function _update(
    uint256 _amount0,
    uint256 _amount1,
    bool isToken0,
    bytes memory activity
) private {
    if (keccak256(activity) == keccak256(bytes("swap"))) {
        // ...
        // ...
    } else {
        // ...
        // ...
    }
}