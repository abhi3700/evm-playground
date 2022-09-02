/* 
    In Solidity, we use struct & parse inside the constructor, function.
    When doing the same during deployment or function call, we need to do the following:
*/

import { BigNumber, Contract, ContractFactory } from "ethers";

interface Stf {
  baseToken: string;
  tradeDirection: boolean;
  fundraisingPeriod: number;
  entryPrice: BigNumber;
  targetPrice: BigNumber;
  liquidationPrice: BigNumber;
  leverage: number;
}

const _stf: Stf = <Stf>{
  baseToken: "0x5802918dC503c465F969DA0847b71E3Fbe9B141c",
  tradeDirection: true,
  fundraisingPeriod: 15 * 60,
  entryPrice: BigNumber.from(String(1000e6)),
  targetPrice: BigNumber.from(String(2000e6)),
  liquidationPrice: BigNumber.from(String(1e18)),
  leverage: 1,
};
