// SPDX-License-Identifier: MIT

/*

    About
    =====
    - 2 contracts - A, B
    - Also, set address of contract B within contract A's state variable - `addressB`
    - A calls B's hello() function & gets the output
    
    Testing
    =======
    - Deploy both contracts A, B to different addresses
    - copy the address of B into setAddress() of A
    - call contract A's callHello() function & get the output 

    Reference
    =========
    * https://www.youtube.com/watch?v=YxU87o4U5iw
    * https://ethereum.stackexchange.com/a/19343/76168
*/


pragma solidity ^0.8.6;

contract A {
    // M-1
/*    function callHello(address _addr) external {
        B b = B(_addr);
        return b.helloWorld();
    }
*/

    // -----------------------------------------------
    // M-2
    address addressB;

    function setAddress(address _addr) external {
        addressB = _addr;
    }

    function callHello() external view returns(string memory){
        B b = B(addressB);
        return b.hello();
    }

}

// contract B {
//     function hello() external pure returns(string memory) {
//         return "hello world";
//     }
// }