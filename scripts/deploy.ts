import { ethers } from "hardhat"
import addresses from "../addresses.json"

// Set these before proceeding
const env = "testnet" // "testnet" || "mainnet"
const slicerId = 1 // The ID of the slicer that will be able to interact with this contract

async function main() {
  console.log("deploying")

  const CONTRACT = await ethers.getContractFactory("MyContract")
  const contract = await CONTRACT.deploy(
    addresses[env]["ProductsModule"],
    slicerId
  )
  await contract.deployed()

  console.log("deploying completed successfully! Address: " + contract.address)
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })
