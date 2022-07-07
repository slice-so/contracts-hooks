import { ethers } from "hardhat"

export const deployContract = async (
  contractName: string,
  initParams: any[] = []
) => {
  const CONTRACT = await ethers.getContractFactory(contractName)
  const contract = await CONTRACT.deploy(...initParams)
  await contract.deployed()

  return contract
}
