import { ethers } from "hardhat"

const contractName = "BaseDayOne"
const productsModule = "0xb9d5B99d5D0fA04dD7eb2b0CD7753317C2ea1a84" // base

const deployContract = async (contractName: string, initParams: any[] = []) => {
  const CONTRACT = await ethers.getContractFactory(contractName)
  const contract = await CONTRACT.deploy(...initParams)
  await contract.deployed()

  return contract
}

async function main() {
  console.log("deploying...")

  let contractSlc = await deployContract(contractName, [productsModule])
  console.log(contractName + " deployed at the address: ", contractSlc.address)
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })
