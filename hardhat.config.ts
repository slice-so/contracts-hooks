import { subtask } from "hardhat/config"
import { TASK_COMPILE_SOLIDITY_GET_SOLC_BUILD } from "hardhat/builtin-tasks/task-names"
import dotenv from "dotenv"
import path from "path"
import "@typechain/hardhat"
import "@openzeppelin/hardhat-upgrades"
import "@nomiclabs/hardhat-waffle"
import "solidity-coverage"
import "hardhat-gas-reporter"
import "@nomiclabs/hardhat-etherscan"

dotenv.config()

module.exports = {
  defaultNetwork: "hardhat",
  networks: {
    hardhat: { chainId: 1337 },
    rinkeby: {
      url: process.env.URL_RINKEBY,
      accounts: {
        mnemonic: process.env.MNEMONIC,
      },
    },
    mainnet: {
      url: process.env.URL_MAINNET,
      accounts: {
        mnemonic: process.env.MNEMONIC,
      },
      gasPrice: 13000000000,
    },
  },
  solidity: {
    version: "0.8.13",
    settings: {
      // viaIR: true,
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  paths: {
    sources: "./contracts",
    tests: "test",
    cache: "./cache",
    artifacts: "./artifacts",
  },
  mocha: {
    timeout: 40000,
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_KEY,
  },
  gasReporter: {
    enabled: process.env.REPORT_GAS ? true : false,
    currency: "USD",
    gasPrice: 50,
    coinmarketcap: process.env.COINMARKETCAP_KEY,
  },
}

subtask(
  TASK_COMPILE_SOLIDITY_GET_SOLC_BUILD,
  async (args: any, hre: any, runSuper: any) => {
    if (args.solcVersion === "0.8.13") {
      const compilerPath = path.join(
        __dirname,
        "build",
        "solc",
        "soljson-v0.8.13+commit.abaa5c0e.js"
      )

      return {
        compilerPath,
        isSolcJs: true, // if you are using a native compiler, set this to false
        version: args.solcVersion,
        // this is used as extra information in the build-info files, but other than
        // that is not important
        longVersion: "0.8.13+commit.abaa5c0e",
      }
    }

    // we just use the default subtask if the version is not 0.8.13
    return runSuper()
  }
)
