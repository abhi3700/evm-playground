# Vesting

## Features

- Use Diamond standard proxy method for upgradation of the contract. This helps in making the contract modular.
- Use Merkle tree for verifying whether a user is a part of the vesting SC or not i.e. "Address validation"
- Whenever creating a vesting for a user irrespective of allocation types - private, seed, team, the vesting schedule id is going to vary. This can be implemented when following SC mapping storage approach.
- Implementation wise, we need to consider these:
  - **Project Tokenomics**: That would lead to the decision of vesting type for different categories of users.
  - **Blockchain Selection**: That would lead to the decision of the SC storage approach for the vesting schedule data. If Solana, EOSIO, then we would have to go for an approach with amount calculation (on-chain) & address validation (off-chain using MT). If Ethereum, then we can go for an approach based on either fully on-chain or on-chain+off-chain

## Vesting types

Two components that has to be considered while implementing vesting:

1.  **Amount calculation**. The following two types are w.r.t the **same** or **different** token amount distribution for a user in a category throughout the vesting period i.e. same amount every release or different amount every release.

    1.  **Uniform distribution** [RECOMMENDED]: Same amount for each release. E.g. For a user, the amount released at each interval is same i.e. week-1: 1000, week-2: 1000, ....

        > Only in case of **airdrop**, the amounts can be same/different for all users i.e. E.g-1 (same). user-1: 1000, user-2: 1000, user-3: 1000. E.g-2 (different): user-1: 1000, user-2: 1500, user-3: 3000

        - In case of vesting, the metadata required for the calculation of `total_released_amount` (to date) for a user (in a category) is:
          - `vesting_period`
          - `start_time`
          - `release_frequency`
          - `cliff` (optional)
          - `amount_per_release`

        Here, we can calculate the `total_released_amount` for a user (in a category) by using the formula: `total_released_amount = vesting_period * release_frequency * amount_per_release`. And also need `start_time` to figure out if the vesting period is elapsed when a user is trying to claim the tokens i.e. status of a vesting - `vesting_status` (active, expired, terminated, etc.)

        > For the calculation of `total_released_amount` to date, has to be checked for gas_consumption following a long vesting period (VP: 5 years, RF: 1 week). For a user, lot of computation has to be done on-chain, if the vesting period is long & the token release is frequent.
        >
        > NOTE: We need the `total_vested_amount` to be put into the `claim` function as a parameter. This is to ensure that the user is not claiming more than what he/she is entitled to. Here, need to ensure that the `total_vested_amount` would be a part of MT, which would ensure no other amount is entered by the user in the `claim` function. We store the `total_vested_amount` on the cloud DB for each user as key-value pair. Basically, in the cloud DB, we store these:

        A dictionary or ordered_map with user address as key & `total_vested_amount` as value like this:

        ```json
        {
          "0xa1": 1000,
          "0xa2": 1500
        }
        ```

        Based on the order of key, we can generate the MT root hash & the MT proof for each user by concatenating the key & value as leaf node.

        From this DB, the user would be able to view the `total_vested_amount` for himself/herself. And the `total_vested_amount` would be used in the `claim` function as parameter in order to eventually verify the amount that the user is claiming (if more than once like in case of vesting).

        > Using the `total_vested_amount` (parsed in `claim()` func) & `total_released_amount` (calculated for a user in a category), we can calculate the `claimable_amount` for a user (in a category). Did a project (token distribution platform) on this at Rapid Innovation. Codebase available locally.

    2.  **Non-uniform distribution** [EXCEPTION]: Different/Arbitrary amount of tokens are released at different intervals based on release frequency. E.g. for a user, 1000 tokens are released in the first month, 2000 tokens are released in the second month, 2010 tokens are released in the third month, 2100 tokens are released in the fourth month, 5000 tokens are released in the fifth month, 6000 tokens are released in the sixth month. Here, the detailed CSV file (format) is available for the release schedule data for each category with users in it.

        - The calculation for `total_released_amount` for a user (in a category) can be done only outside the SC. This means for a very long period & more frequent release, the amount has to be saved into the cloud DB & the summation has to be performed outside the SC. Following this, we get the `total_released_amount` for a user (in a category).

2.  **Address validation**

The implementation depends on the type of vesting. It can be done via either:

1. **`mapping` SC storage**: takes a lot of SC storage space. Not recommended for a large userbase in case of Solana blockchain.
2. **`merkle Tree` cloud DB storage**: takes computation time to calculate the `merkle proof` off chain. But, it is recommended for a large userbase (especially for Solana blockchain).

### Simple Vesting

Full on-chain vesting. No merkle tree. No off-chain computation.

1. Amount calculation: Same amount of tokens are released at the different intervals based on release frequency. E.g. 1000 tokens are released every month for 6 months.
2. Address Validation: `mapping` SC storage

### Airdrop

#### Simple (only Merkle)

Here, the airdrop has to implement **merkle tree** only. And the claimable amounts are **claimed only once** => **No vesting**.

But, if we want to do so, we can use vesting & the implementation would be like this:

1. amount calculation (in case of uniform/non-uniform distribution of tokens per release for each user)

   1. Types
      1. _same amount for all users_. E.g. user-1: 1000, user-2: 1000, user-3: 1000
      2. _different amount for all users_. E.g. user-1: 1000, user-2: 1500, user-3: 3000
   2. Implementation: For 1st type, we have to store the `claimable_amount` as state variable in the SC. For 2nd type, we have to store the `claimable_amount` as mapping in the SC if the userbase is small, otherwise the `claimable_amount` has to be stored in cloud DB for all users.

   Additionally, we can maintain a boolean info for all users so as to ensure that the user has claimed the tokens or not. This can be done by using a mapping in the SC. `mapping(address => bool) claimed;`

2. address validation i.e. whether the claimer is a part of the category or not has to be done from inside the SC, provided we have the `address list` stored in cloud DB. From where we would calculate the `merkle proof` off chain for the claimer `address`.

#### Merkle + Vesting

Here, the airdrop has to implement **merkle tree**. And the claimable amounts has to be **vested** following the release schedule as given.

> Normally, airdrops are not vested for any user.

But, if we want to do so, we can use vesting & the implementation would be like this:

1. amount calculation (for Uniform token distribution along the vesting): has to be done from inside the SC. Need to be concerned about gas_cost in case of long vesting period. `claim()` function needs to have these params:
   1. claimer_address (as `msg.sender`)
   2. `total_vested_amount` (fetched from cloud DB)
   3. `merkle_proof` (fetched from cloud DB list of addresses (order matters))
2. address validation i.e. whether the claimer is a part of the category or not has to be done from inside the SC, provided we have the `address list` stored in cloud DB. From where we would calculate the `merkle proof` off chain for the claimer `address`.

## References

- https://github.com/abdelhamidbakhta/token-vesting-contracts/blob/main/contracts/TokenVesting.sol
