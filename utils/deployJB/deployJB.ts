import { ethers } from "hardhat"
import { BigNumber } from "ethers"
import { a0, jb, JBOwner } from "../../test/setup"

import { OperatorStore } from "../../typechain-types/OperatorStore"
import { Projects } from "../../typechain-types/Projects"
import { Prices } from "../../typechain-types/Prices"
import { TerminalDirectory } from "../../typechain-types/TerminalDirectory"
import { FundingCycles } from "../../typechain-types/FundingCycles"
import { TicketBooth } from "../../typechain-types/TicketBooth"
import { ModStore } from "../../typechain-types/ModStore"
import { Governance } from "../../typechain-types/Governance"
import { TerminalV1 } from "../../typechain-types/TerminalV1"
import { TerminalV11 } from "../../typechain-types/TerminalV11"

export let operatorStore: OperatorStore,
  projects: Projects,
  prices: Prices,
  terminalDirectory: TerminalDirectory,
  fundingCycles: FundingCycles,
  ticketBooth: TicketBooth,
  modStore: ModStore,
  governance: Governance,
  terminalV1: TerminalV1,
  terminalV1_1: TerminalV11,
  SLXAddress: string

export const deployJB = async () => {
  const OPERATORSTORE = await ethers.getContractFactory("OperatorStore")
  const operatorStoreContract = await OPERATORSTORE.deploy()
  await operatorStoreContract.deployed()

  const PROJECTS = await ethers.getContractFactory("Projects")
  const projectsContract = await PROJECTS.deploy(operatorStoreContract.address)
  await projectsContract.deployed()

  const PRICES = await ethers.getContractFactory("Prices")
  const pricesContract = await PRICES.deploy()
  await pricesContract.deployed()

  const TERMINALDIRECTORY = await ethers.getContractFactory("TerminalDirectory")
  const terminalDirectoryContract = await TERMINALDIRECTORY.deploy(
    projectsContract.address,
    operatorStoreContract.address
  )
  await terminalDirectoryContract.deployed()

  const FUNDINGCYCLES = await ethers.getContractFactory("FundingCycles")
  const fundingCyclesContract = await FUNDINGCYCLES.deploy(
    terminalDirectoryContract.address
  )
  await fundingCyclesContract.deployed()

  const TICKETBOOTH = await ethers.getContractFactory("TicketBooth")
  const ticketBoothContract = await TICKETBOOTH.deploy(
    projectsContract.address,
    operatorStoreContract.address,
    terminalDirectoryContract.address
  )
  await ticketBoothContract.deployed()

  const MODSTORE = await ethers.getContractFactory("ModStore")
  const modStoreContract = await MODSTORE.deploy(
    projectsContract.address,
    operatorStoreContract.address,
    terminalDirectoryContract.address
  )
  await modStoreContract.deployed()

  const GOVERNANCE = await ethers.getContractFactory("Governance")
  const governanceContract = await GOVERNANCE.deploy(
    1,
    terminalDirectoryContract.address
  )
  await governanceContract.deployed()

  const TERMINALV1 = await ethers.getContractFactory("TerminalV1")
  const terminalV1Contract = await TERMINALV1.deploy(
    projectsContract.address,
    fundingCyclesContract.address,
    ticketBoothContract.address,
    operatorStoreContract.address,
    modStoreContract.address,
    pricesContract.address,
    terminalDirectoryContract.address,
    governanceContract.address
  )
  await terminalV1Contract.deployed()

  const TERMINALV1_1 = await ethers.getContractFactory("TerminalV1_1")
  const terminalV1_1Contract = await TERMINALV1_1.deploy(
    projectsContract.address,
    fundingCyclesContract.address,
    ticketBoothContract.address,
    operatorStoreContract.address,
    modStoreContract.address,
    pricesContract.address,
    terminalDirectoryContract.address,
    jb
  )
  await terminalV1_1Contract.deployed()

  const PROXYPAYMENTADDRESSMANAGER = await ethers.getContractFactory(
    "ProxyPaymentAddressManager"
  )
  const proxyPaymentAddressManagerContract =
    await PROXYPAYMENTADDRESSMANAGER.deploy(
      terminalDirectoryContract.address,
      ticketBoothContract.address
    )
  await proxyPaymentAddressManagerContract.deployed()

  operatorStore = operatorStoreContract as OperatorStore
  projects = projectsContract as Projects
  prices = pricesContract as Prices
  terminalDirectory = terminalDirectoryContract as TerminalDirectory
  fundingCycles = fundingCyclesContract as FundingCycles
  ticketBooth = ticketBoothContract as TicketBooth
  modStore = modStoreContract as ModStore
  governance = governanceContract as Governance
  terminalV1 = terminalV1Contract as TerminalV1
  terminalV1_1 = terminalV1_1Contract as TerminalV11

  // Set governance as the prices contract owner.
  await prices.transferOwnership(governanceContract.address)
  /** 
      Deploy the governance contract's project. It will have an ID of 1.
    */
  await terminalV1_1.deploy(
    jb,
    ethers.utils.formatBytes32String("slice"),
    "",
    {
      target: 0,
      currency: 0,
      // Duration must be zero so that the same cycle lasts throughout the tests.
      duration: 0,
      cycleLimit: ethers.BigNumber.from(0),
      discountRate: ethers.BigNumber.from(0),
      ballot: ethers.constants.AddressZero,
    },
    {
      reservedRate: 0,
      bondingCurveRate: 0,
      reconfigurationBondingCurveRate: 0,
      payIsPaused: false,
      ticketPrintingIsAllowed: true,
      treasuryExtension: ethers.constants.AddressZero,
    },
    [],
    []
  )

  await ticketBooth.connect(JBOwner).issue(1, "Slice Protocol", "SLX")
  await terminalV1_1
    .connect(JBOwner)
    .printTickets(1, BigNumber.from(10).pow(24), a0, "", true)

  SLXAddress = await ticketBooth.ticketsOf(1)

  // console.log(SLXAddress);
  // console.log(terminalV1_1.address); // Terminal address
}
