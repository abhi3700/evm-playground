// SPDX-License-Identifier: MIT
pragma solidity 0.8.6;

/*
In order to better understand, try it in Remix IDE.

*/

import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol';

contract MyArray{
    using SafeMath for uint256;
    uint256[] public arr1;
    
    // @notice insert from back
    function insert(uint256 a) external {
        arr1.push(a);
    }

    // @notice insert at index
    function insertatIndex(uint256 index, uint256 val) external {
        require(index >= 0 && index < arr1.length, "invalid index");
        uint256 lastElement = arr1[arr1.length-1];
        
        uint256 t = arr1[index];
        arr1[index] = val;

        for(uint256 i=arr1.length; i > index; --i) {
            if(i == arr1.length)
                arr1.push(lastElement);
            else if(i == index+1)
                arr1[i] = t;
            else
                arr1[i] = arr1[i-1];
        }

    }
        
    // @notice update the array value by index
    function update(uint256 index, uint256 value) external {
        require(arr1.length > 0, "the array length must be positive");
        require(index >= 0 && index < arr1.length, "invalid index");
        
        arr1[index] = value;
    }

    // @notice get size/length of array
    function getSize() external view returns (uint256) {
        return arr1.length;
    }
    
    // @notice remove last element from array 
    function getLastElement() external view returns (uint256) {
        require(arr1.length > 0, "the array length must be positive");
        return arr1[arr1.length - 1];
    }

    // @notice remove element (by index) from array 
    function removebyIndex(uint256 index) external {
        // M-1
        // delete arr1[index];         // consumes 5000 gas. So, it's not recommended.
        
        require(index >= 0 && index < arr1.length, "invalid index");
        
        // M-2
        for(uint256 i = index; i < arr1.length-1; ++i) {
            arr1[i] = arr1[i+1];
        }
        
        arr1.pop();     // reduce the array length for v0.6+
    }
    
    // @notice get Array elements at a glance
    function getArray() external view returns (uint256[] memory) {
        return arr1;
    }
}