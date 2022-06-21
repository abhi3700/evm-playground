# Length of Loop

## Applications

- How to define the length of loop

## Coding

- Below is the code snippet where the length is defined for a loop

```solidity

// INSECURE
function _canBeCanceled(Timelock storage timelock) view private returns (bool){
    for (uint256 i = 0; i < timelock.cancelableBy.length; i++) {
        if (msg.sender == timelock.cancelableBy[i]) {
            return true;
        }
    }
    return false;
}
// SECURE
function _canBeCanceled(Timelock storage timelock) view private returns (bool){
    uint256 len = timelock.cancelableBy.length;
    for (uint256 i = 0; i < len; i++) {
        if (msg.sender == timelock.cancelableBy[i]) {
            return true;
        }
    }
    return false;
}
```

## Problem

- During each iteration, the length is determined from a state variable (`storage` type) which consumes additional gas cost.

## Solution

- This can be reduced by declaring a local variable outside the `for` loop so that the length is computed once instead of every iteration in loop.

## References

- `tkz-opgames` repo at Upside.
