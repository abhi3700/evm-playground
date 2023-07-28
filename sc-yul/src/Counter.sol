// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Counter {
    uint256 public count;

    constructor() {
        assembly {
            sstore(count.slot, 20)
        }
    }

    function increment() public {
        assembly {
            sstore(count.slot, add(sload(count.slot), 1))
        }
    }

    /// NOTE: I tried comparing the gas cost of
    /// both solidity and assembly versions of increment()
    /// sol: 13051
    /// yul: 12851
    // function increment() public {
    //     count += 1;
    // }

    function decrement() public {
        assembly {
            let c := sload(count.slot)
            if gt(c, 0) { sstore(count.slot, sub(c, 1)) }
        }
    }

    function set(uint256 val) public {
        assembly {
            sstore(count.slot, val)
        }
    }

    function reset() public {
        assembly {
            sstore(count.slot, 0)
        }
    }
}
