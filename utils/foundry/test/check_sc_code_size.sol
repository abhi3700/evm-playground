/* 
    Check if the SC is deployed:
        - non-zero address
        - non-zero code size
*/

contract SCTest {
    function testGetReceiptToken() public {
        // M-1: check if receipt token is deployed
        // assertTrue(address(vault.rCRVstETH()) != ZERO_ADDRESS);

        // M-2: check the code size of the contract
        address _rToken = address(vault.rCRVstETH());

        uint256 hevmCodeSize = 0;
        assembly {
            hevmCodeSize := extcodesize(_rToken)
        }
        assertTrue(hevmCodeSize > 0);
    }
}
