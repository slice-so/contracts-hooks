import { ethers } from "hardhat"

const productsModule = "0x61bCd1ED11fC03C958A847A6687b1875f5eAcaaf"
const fundsModule = "0x115978100953D0Aa6f2f8865d11Dc5888f728370"

const deployContract = async (contractName: string, initParams: any[] = []) => {
  const CONTRACT = await ethers.getContractFactory(contractName)
  const contract = await CONTRACT.deploy(...initParams)
  await contract.deployed()

  return contract
}

async function main() {
  console.log("deploying SLC...")

  let contractSlc = await deployContract("SLC", [productsModule, fundsModule])
  console.log("SLC at the address: ", contractSlc.address)
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })
