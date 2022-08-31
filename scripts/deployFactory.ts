import { ethers } from "hardhat"

const contractName = "" // Name of the logic contract address

async function main() {
  const factory = contractName + "Factory"
  const cloner = contractName + "Cloner"

  // Deploy factory contract

  console.log("deploying " + factory)

  const FACTORY = await ethers.getContractFactory(factory)
  const factoryContract = await FACTORY.deploy()
  await factoryContract.deployed()

  console.log(
    "Factory contract deployed successfully! Address: " +
      factoryContract.address
  )

  // Deploy cloner contract

  console.log("deploying " + cloner)

  const CLONER = await ethers.getContractFactory(cloner)
  const contractCloner = await CLONER.deploy()
  await contractCloner.deployed()

  console.log(
    "Cloner contract deployed successfully! Address: " + contractCloner.address
  )
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })
