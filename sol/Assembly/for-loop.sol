/* 
    Convert solidity to inline assembly
*/

function for_loop_solidity(uint256 n, uint256 value)
    public
    pure
    returns (uint256)
{
    for (uint256 i = 0; i < n; i++) {
        value = 2 * value;
    }
    return value;
}


// Convert the above function from solidity to assembly
function for_loop_assembly(uint256 n, uint256 value)
    public
    pure
    returns (uint256)
{
    assembly {
        for {let i} lt(i, n) {i := add(i, 1)} {
            value := mul(2, value)
        }

        mstore(0x00, value)     // store value in memory
        return(0x00, 32)        // return 32 bytes i.e. 256 bits (uint256) from the memory address 0x00
    }
}
