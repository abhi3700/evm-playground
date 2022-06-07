// check array has non-zero elements
function _arrayIsNonzero(uint256[] memory arr) internal pure returns (bool) {
    uint256 arrLen = arr.length;
    for (uint256 i; i < arrLen; ++i) {
        if (arr[i] != 0) {
            return true;
        }
    }
    return false;
}

// check two arrays doesn't have same elements for same index
function _requireNoOverlapColls(
    address[] calldata _colls1,
    address[] calldata _colls2
) internal pure {
    uint256 colls1Len = _colls1.length;
    uint256 colls2Len = _colls2.length;
    for (uint256 i; i < colls1Len; ++i) {
        for (uint256 j; j < colls2Len; j++) {
            require(_colls1[i] != _colls2[j], "Same elements");
        }
    }
}

// check the array has no duplicate elements
function _requireNoDuplicateColls(address[] memory _colls) internal pure {
    uint256 collsLen = _colls.length;
    for (uint256 i; i < collsLen; ++i) {
        for (uint256 j = (i + 1); j < collsLen; j++) {
            require(_colls[i] != _colls[j], "Duplicate elements");
        }
    }
}

// check 2 arrays are of same length
function _requireSameLen(address[] memory _coll1, address memory _coll2) internal pure {
    require(_coll1.length == _coll2.length, "Unequal length")
}
