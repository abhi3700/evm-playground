---
title: How the struct is stored in slot
---

```solidity
// slot 6 - length of array
// starting from slot hash(6) - array elements
// slot where array element is stored = keccak256(slot)) + (index * elementSize)
// where slot = 6 and elementSize = 2 (1 (uint) +  1 (bytes32))
User[] private users;
```

**Explanation**:

The given Solidity code snippet defines a private dynamic array called `users`. The commented lines provide information on how the storage layout for this array is organized in Ethereum's storage. Let's break down the comments:

1. `// slot 6 - length of array`: This comment indicates that the length of the array is stored in storage slot 6. In Solidity, dynamic arrays store their length in a specific storage slot[6].

2. `// starting from slot hash(6) - array elements`: This comment explains that the array elements are stored starting from the storage slot calculated by hashing the slot number (6 in this case). This is a common pattern for dynamic arrays in Solidity[14].

3. `// slot where array element is stored = keccak256(slot)) + (index * elementSize)`: This comment provides the formula to calculate the storage slot for a specific array element. The formula is as follows:
   - `keccak256(slot)`: Compute the Keccak-256 hash of the slot number (6) [3].
   - `index`: The index of the array element you want to access.
   - `elementSize`: The size of each element in the array. In this case, it is 2 (1 for `uint` and 1 for `bytes32`).
   - Add the hash and the product of the index and element size to get the storage slot for the desired array element[7].

In summary, the comments describe how the storage layout for the `users` dynamic array is organized in Ethereum's storage. The length of the array is stored in slot 6, and the elements are stored starting from the hashed slot number. The storage slot for a specific element can be calculated using the provided formula.

**Citations**:

- [1] https://intellipaat.com/blog/tutorial/blockchain-tutorial/what-is-solidity/
- [2] https://docs.soliditylang.org/en/latest/internals/layout_in_storage.html
- [3] https://solidity-by-example.org/hashing/
- [4] https://docs.soliditylang.org/en/latest/types.html
- [5] https://www.w3schools.io/blockchain/solidity-comments/
- [6] https://docs.soliditylang.org/en/latest/internals/layout_in_storage.html?highlight=is+
- [7] https://solidity-by-example.org/hacks/accessing-private-data/
- [8] https://www.simplilearn.com/tutorials/blockchain-tutorial/what-is-solidity-programming
- [9] https://www.tutorialspoint.com/solidity/solidity_arrays.htm
- [10] https://www.quicknode.com/guides/ethereum-development/smart-contracts/how-to-use-keccak256-with-solidity
- [11] https://solidity-by-example.org/array/
- [12] https://www.tutorialspoint.com/solidity/solidity_comments.htm
- [13] https://ethereum.stackexchange.com/questions/69931/how-to-get-access-to-the-storage-array-through-the-solidity-assembler
- [14] https://ethereum.stackexchange.com/questions/140776/where-inside-smart-contract-storage-are-dynamic-array-values-stored
- [15] https://docs.soliditylang.org
- [16] https://ethereum.stackexchange.com/questions/42445/how-to-properly-initialize-a-storage-array
- [17] https://medium.com/0xcode/hashing-functions-in-solidity-using-keccak256-70779ea55bb0
- [18] https://www.geeksforgeeks.org/solidity-arrays/
- [19] https://jeancvllr.medium.com/solidity-tutorial-all-about-comments-bc31c729975a
- [20] https://mixbytes.io/blog/collisions-solidity-storage-layouts
- [21] https://programtheblockchain.com/posts/2018/03/09/understanding-ethereum-smart-contract-storage/
- [22] https://www.tutorialspoint.com/solidity/solidity_quick_guide.htm
- [23] https://www.alchemy.com/overviews/solidity-arrays
- [24] https://cryptomarketpool.com/keccak256/
- [25] https://ethereum.stackexchange.com/questions/24061/is-there-a-maximum-array-size-in-solidity
- [26] https://101blockchains.com/comments-in-solidity/
- [27] https://medium.com/coinmonks/solidity-storage-how-does-it-work-8354afde3eb
- [28] https://solidity-fr.readthedocs.io/fr/latest/internals/layout_in_storage.html
- [29] https://learnxinyminutes.com/docs/solidity/
- [30] https://medium.com/coinmonks/array-and-map-in-solidity-a579b311d74b
- [31] https://www.educative.io/answers/what-is-hashing-with-keccak256-in-solidity
- [32] https://jeancvllr.medium.com/solidity-tutorial-all-about-array-efdff4613694
- [33] https://www.bitdegree.org/learn/solidity-syntax
- [34] https://solidity-by-example.org/app/write-to-any-slot/
- [35] https://solidity-kr.readthedocs.io/ko/latest/miscellaneous.html
- [36] https://www.geeksforgeeks.org/introduction-to-solidity/
- [37] https://coinsbench.com/solidity-layout-and-access-of-storage-variables-simply-explained-1ce964d7c738
- [38] https://www.tutorialspoint.com/solidity/solidity_cryptographic_functions.htm
- [39] https://kristaps.me/blog/solidity-array
- [40] https://www.geeksforgeeks.org/solidity-comments/
- [41] https://enderspub.kubertu.com/understand-solidity-storage-in-depth
- [42] https://www.netspi.com/blog/technical/blockchain-penetration-testing/ethereum-virtual-machine-internals-part-2/
- [43] https://www.geeksforgeeks.org/solidity-basics-of-contracts/
- [44] https://www.geeksforgeeks.org/storage-vs-memory-in-solidity/
- [45] https://youtube.com/watch?v=wCD3fOlsGc4
- [46] https://techblog.geekyants.com/tips-and-tricks-in-solidity
- [47] https://blockchainknowledge.in/guide-to-comments-in-solidity-including-natspec-format/
- [48] https://stackoverflow.com/questions/72014421/in-what-slots-are-variables-stored-that-are-defined-after-an-array-in-solidity
- [49] https://dev.to/web3_ruud/advance-solidity-assembly-storage-slots-part-2-197e
- [50] https://medium.com/coinmonks/solidity-explained-with-coding-examples-e40ac3e784fb
- [51] https://blockchainknowledge.in/arrays-in-solidity-fixed-size-array-dynamic-array-storage-array-memory-array/
- [52] https://coinsbench.com/solidity-25-keccak256-50776e91eae6
- [53] https://kuizzer.com/solidity-comments/
