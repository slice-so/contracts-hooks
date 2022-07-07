import { ethers } from "hardhat"

export const calculateTimestamp = async (secondsDelay = 0): Promise<number> => {
  const currentTimestamp = (await ethers.provider.getBlock("latest")).timestamp
  return currentTimestamp + secondsDelay
}
