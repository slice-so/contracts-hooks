import { ethers } from "hardhat"
import { Signer } from "ethers"
import { SliceCore } from "../typechain-types/SliceCore"
import { SlicerManager } from "../typechain-types/SlicerManager"
import { ProductsModule } from "../typechain-types/ProductsModule"
import { FundsModule } from "../typechain-types/FundsModule"
import { Erc20 } from "../typechain-types/ERC20"
import { deployJB, deployUUPS, upgradeUUPS } from "../utils"
import { SLXAddress } from "../utils/deployJB/deployJB"

/**
 * @title Setup file
 * @author Dom-Mac
 *
 * @notice contracts are deployed just once before all the tests.
 *
 * @dev
 */

// protocolFee corresponds to 2.5% (0.025)
export const protocolFee = 25
export let addr0: Signer,
  addr1: Signer,
  addr2: Signer,
  addr3: Signer,
  addr4: Signer,
  addr5: Signer,
  addr6: Signer,
  addr7: Signer,
  JBOwner: Signer,
  a0: string,
  a1: string,
  a2: string,
  a3: string,
  a4: string,
  a5: string,
  a6: string,
  a7: string,
  jb: string,
  beacon: string,
  sliceCore: SliceCore,
  productsModule: ProductsModule,
  fundsModule: FundsModule,
  slicerManager: SlicerManager,
  slx: Erc20,
  signature721 = "0xfaf2e80e",
  signature1155 = "0x81bfbb80",
  onProductPurchaseSignature = "0xa23fffb9",
  isPurchaseAllowedSignature = "0x95db9368"

before(async () => {
  const [
    address0,
    address1,
    address2,
    address3,
    address4,
    address5,
    address6,
    address7,
    address8,
  ] = await ethers.getSigners()

  // Deploy empty contracts to get addresses to be hardcoded
  let contractSliceCore = await deployUUPS("EmptyUUPS")
  let contractProductsModule = await deployUUPS("EmptyUUPS")
  let contractFundsModule = await deployUUPS("EmptyUUPS")
  let contractSlicerManager = await deployUUPS("EmptyUUPSBeacon", [
    contractSliceCore.address,
  ])

  // Deploy slicer contract
  const CONTRACTBEACON = await ethers.getContractFactory("Slicer")
  const beaconImplementation = await CONTRACTBEACON.deploy()

  // Upgrade empty contracts with logic
  sliceCore = (await upgradeUUPS(
    contractSliceCore.address,
    "SliceCore"
  )) as SliceCore

  productsModule = (await upgradeUUPS(
    contractProductsModule.address,
    "ProductsModule"
  )) as ProductsModule

  fundsModule = (await upgradeUUPS(
    contractFundsModule.address,
    "FundsModule"
  )) as FundsModule

  slicerManager = (await upgradeUUPS(
    contractSlicerManager.address,
    "SlicerManager"
  )) as SlicerManager

  // Set basePath
  const basePath = "https://dev.slice.so/api/slicer/"
  await sliceCore._setBasePath(basePath)

  // Update initial slicer implementation address in {SlicerManager}
  await slicerManager._upgradeSlicers(beaconImplementation.address)

  a0 = address0.address
  a1 = address1.address
  a2 = address2.address
  a3 = address3.address
  a4 = address4.address
  a5 = address5.address
  a6 = address6.address
  a7 = address7.address
  jb = address8.address
  addr0 = address0
  addr1 = address1
  addr2 = address2
  addr3 = address3
  addr4 = address4
  addr5 = address5
  addr6 = address6
  addr7 = address7
  JBOwner = address8
  beacon = beaconImplementation.address

  // Deploy JB contracts + SLX
  await deployJB()

  slx = (await ethers.getContractAt("ERC20", SLXAddress)) as Erc20

  await slx.approve(productsModule.address, 10000000000)

  console.log("~~~~~~~~ TESTS ~~~~~~~~ \n")
})
