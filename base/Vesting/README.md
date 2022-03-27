# Vesting

## Features
* Use Diamond standard for upgradation.
* Use Merkle tree for verifying whether a user is a part of the vesting SC or not.
* Whenever creating a vesting for a user irrespective of allocation types - private, seed, team, the vesting schedule id is going to vary.
* Features like whitelist, blacklist a user. Here, they are not removed from the Merkle tree.

## References
* https://github.com/abdelhamidbakhta/token-vesting-contracts/blob/main/contracts/TokenVesting.sol
