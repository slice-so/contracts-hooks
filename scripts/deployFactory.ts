import { ethers } from "hardhat"

const contractName = "AllowlistedCloner"

async function main() {
  console.log("deploying")

  const CONTRACT = await ethers.getContractFactory(contractName)
  const contract = await CONTRACT.deploy()
  await contract.deployed()

  console.log("Contract deployed successfully! Address: " + contract.address)
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })
