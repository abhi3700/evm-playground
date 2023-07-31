---
title: Define & Deploy contracts inside the test contract
---

Define like a state variable:

```solidity
// test/Counter.t.sol
contract CounterTest is Test {
    // declare contracts as state variables
    Counter public counter;
    MyToken private _token;

    function setUp() public {
        // deploy contracts
        counter = new Counter();
        _token = new MyToken("Donut", "DONUT", 18);
    }
}
```
