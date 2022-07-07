import { ethers, upgrades } from "hardhat"

export const upgradeUUPS = async (
  deployedAddress: string,
  contractName: string
) => {
  const CONTRACT = await ethers.getContractFactory(contractName)
  const contract = await upgrades.upgradeProxy(deployedAddress, CONTRACT)
  return contract
}
