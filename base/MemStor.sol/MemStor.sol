// SPDX-License-Identifier: MIT

/*

    About
    =====
    - Storage and Memory keywords in Solidity are analogous to Computer’s hard drive and Computer’s RAM. Much like RAM, Memory in Solidity is a temporary place to store data whereas Storage holds data between function calls.
    - State variables and Local Variables of structs, array are always stored in storage by default.
    - Function arguments are in memory.
    - Whenever a new instance of an array is created using the keyword ‘memory’, a new copy of that variable is created. Changing the array value of the new instance does not affect the original array.
    
    Testing (In each cases, the contract is re-deployed)
    =======
    - Case-1: On multiple usage of createstor(), the array would look like this: [1, 200, 1, 200, 1, 200]
    - Case-2: On multiple usage of createmem(), the array would look like this: [1, 2, 1, 2, 1, 2]
    - Case-3: createstor() >> createmem() >> createstor(), the array would look like this: [1,200,1,2,1,2]
        + Once, set as memory, it will continue to stay as memory
    - Case-4: createmem() >> createstor() >> createmem() >> createstor(), the array would look like this: [1,200,1,2,1,2,1,2]
        + Once, set as memory, it will continue to stay as memory

    Reference
    =========
    - https://www.geeksforgeeks.org/storage-vs-memory-in-solidity/
*/

pragma solidity ^0.8.6;

contract MemStor {
    uint[] numbers;

    /*
    Here, it would give output as (1,200), not (1,2)
    */
    // storage demo
    function createstor() external {
        numbers.push(1);
        numbers.push(2);
        
       uint[] storage myArray = numbers;        // use as alias with storage type to make a change at the original state variable.
       myArray[1] = 200;
        
        // numbers[0] = 200;            // this would make change to the original value as storage.
    }

    /*
    Here, it would give output as (1,2), not (1,200)
    */
    // memory demo
    function createmem() external {
        numbers.push(1);
        numbers.push(2);
        
       uint[] memory myArray = numbers;        // use as alias with memory type to make a copy & change. Note that the original state variable is not changed.
       myArray[1] = 200;        
    }

    function getlastitem() external view returns(uint) {
        return numbers[numbers.length - 1];
    }
    
    function getlen() external view returns(uint) {
        return numbers.length;
    }

    function getAllElement()  public view returns (uint[] memory) {
        return numbers;
    }

}