---
title: Transfer Test ETHs to addresses
---

By default, the ETH balance for the Test contract is `79228162514264337593543950335` (in wei).

Now, for tests when we have different accounts - alice, bob, etc. we do need some test ETH to conduct some function. But, it doesn't have that by default.

So, before interacting with SC function, we need to ensure balance in the caller's account via `deal(address(alice), 100)`. So, here is the code snippet:

```solidity
function setUp() public {
    alice = address(1);
    deal(alice, 100);   // set some ETH balance of `alice` account.
}
```
