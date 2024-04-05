// right padded zeros
/* 
```sh
cast --to-bytes32 0x796f2974e3c1af763252512dd6d521e9e984726c
0x796f2974e3c1af763252512dd6d521e9e984726c000000000000000000000000
```
*/
bytes32(uint256(uint160(address(bWTssc))) << 96)