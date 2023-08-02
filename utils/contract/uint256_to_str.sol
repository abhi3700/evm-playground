function uintToStr(uint256 i) internal pure returns (string) {
    if (i == 0) return "0";
    uint256 j = i;
    uint256 length;
    while (j != 0) {
        length++;
        j /= 10;
    }
    bytes memory bstr = new bytes(length);
    uint256 k = length - 1;
    while (i != 0) {
        bstr[k--] = bytes1(48 + i % 10);
        i /= 10;
    }
    return string(bstr);
}
