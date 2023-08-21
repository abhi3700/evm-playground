// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

/// check if bytes8 array has empty elements atleast one.
/// This is useful for cases where I need to ensure that the array doesn't have any element with zero bytes8.
function _isBytes8ArrayElementEmpty(bytes8[4] memory arr) private pure returns (bool) {
    bool isEmpty = false;
    for (uint256 i = 0; i < arr.length; ++i) {
        if (arr[i].length == 0) {
            isEmpty = true;
            break;
        }
    }

    return isEmpty;
}
