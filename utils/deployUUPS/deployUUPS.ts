import { ethers, upgrades } from "hardhat"

export const deployUUPS = async (
  contractName: string,
  initParams: any[] = []
) => {
  const CONTRACT = await ethers.getContractFactory(contractName)
  const contract = await upgrades.deployProxy(CONTRACT, initParams, {
    kind: "uups",
  })
  await contract.deployed()

  return contract
}
