import { BigNumberish } from "ethers";
import { ethers } from "hardhat";
const { BigNumber } = ethers;

export const amountAfterFee = (amount: BigNumberish, protocolFee = 25) =>
  BigNumber.from(amount).sub(BigNumber.from(amount).mul(protocolFee).div(1000));
