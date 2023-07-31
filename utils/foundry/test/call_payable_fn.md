---
title: Call `payable` function
---

In order to call `payable` function, the caller must have some ETH balance. So, we fund that account using `deal(to, value)` function as shown [here](./transfer_eth.md).

Here is the code snippet of **alice** calling a `deposit` function via transferring some 20 ETH (given its balance > 20, say 100):

```solidity
function testDeposit() public {
    vm.prank(alice);
    p.deposit{value: 20}();
    assertEq(address(p).balance, 20);
    assertEq(address(alice).balance, 80);
}
```

for the contract whose deposit function is defined as:

```solidity
function deposit() external payable {}
```
