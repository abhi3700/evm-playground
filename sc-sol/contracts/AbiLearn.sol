// SPDX-License-Identifier: MIT

pragma solidity 0.8.13;

/// @title Learn ABI
/// @dev standard, non-standard/packed, encode function calls
///     defined in the README's ABI section
contract AbiLearn {
    
    function getEncoded(string memory s) public pure returns (bytes memory) {
        return abi.encode(s);
    }
    
    function getEncoded2(string memory s) public pure returns (bytes memory) {
        return abi.encodePacked(s);
    }
    
    function getEncoded3(string memory s1, string memory s2) public pure returns (bytes memory) {
        return abi.encodePacked(s1, s2);
    }
    
    /// @dev Try with a token minted to this contract & then try the `safeTransfer` function
    function safeTransfer(address token, address to, uint256 value) external {
        (bool success, bytes memory data) = token.call(abi.encodeWithSignature("transfer(address,uint256)", to, value));
        require(
            success && (data.length == 0 || abi.decode(data, (bool))),
            "Bioform: TRANSFER_FAILED"
        );
    }

}
