# Overflow Underflow

## Applications

- Transfer token or coin from from one account to another.

## Coding

- Below is the code snippet for transfer token/coin from one account address to another.

```solidity
mapping (address => uint256) public balanceOf;
// INSECURE
function transfer(address _to, uint256 _value) {
    /* Check if sender has balance */
    require(balanceOf[msg.sender] >= _value);
    /* Add and subtract new balances */
    balanceOf[msg.sender] -= _value;
    balanceOf[_to] += _value;
}
// SECURE
function transfer(address _to, uint256 _value) {
    /* Check if sender has balance and for overflows */
    require(balanceOf[msg.sender] >= _value && balanceOf[_to] + _value >= balanceOf[_to]);
    /* Add and subtract new balances */
    balanceOf[msg.sender] -= _value;
    balanceOf[_to] += _value;
}
```

## Problem

- In _insecure_ code snippet, there could be overflow problem on receiver side. E.g. if the receiver has a balance MAX(uint256) i.e. `115,792,089,237,316,195,423,570,985,008,687,907,853,269,984,665,6` & now in addition of extra amount would lead to arithmetic overflow.

## Solution

- That's why `balanceOf[_to] + _value >= balanceOf[_to]` is added in the `require` statement in the _secure_ code snippet.
- [RECOMMENDED] It's better to use `SafeMath.sol` for arithmetic calculation. Only needed for solidity < `0.8.0`

## References

- https://consensys.github.io/smart-contract-best-practices/development-recommendations/general/external-calls/#mark-untrusted-contracts
