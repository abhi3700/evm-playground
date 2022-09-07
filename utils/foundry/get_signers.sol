pragma solidity ^0.8.6;

import "ds-test/test.sol";

interface CheatCodes {
    // Gets address for a given private key, (privateKey) => (address)
    function addr(uint256) external returns (address);
}

contract Test is DSTest {
    address public owner;
    address public addr1;
    address public addr2;

    CheatCodes cheats = CheatCodes(HEVM_ADDRESS);

    function setUp() {
        // new deployed contracts will have Test as owner
        owner = address(this);

        addr1 = cheats.addr(1);
        addr2 = cheats.addr(2);
    }
}
