/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import { Contract, Signer, utils } from "ethers";
import { Provider } from "@ethersproject/providers";
import type { ITerminal, ITerminalInterface } from "../ITerminal";

const _abi = [
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_projectId",
        type: "uint256",
      },
    ],
    name: "addToBalance",
    outputs: [],
    stateMutability: "payable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "contract ITerminal",
        name: "_contract",
        type: "address",
      },
    ],
    name: "allowMigration",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_projectId",
        type: "uint256",
      },
      {
        internalType: "contract ITerminal",
        name: "_to",
        type: "address",
      },
    ],
    name: "migrate",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "contract ITerminal",
        name: "_terminal",
        type: "address",
      },
    ],
    name: "migrationIsAllowed",
    outputs: [
      {
        internalType: "bool",
        name: "",
        type: "bool",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_projectId",
        type: "uint256",
      },
      {
        internalType: "address",
        name: "_beneficiary",
        type: "address",
      },
      {
        internalType: "string",
        name: "_memo",
        type: "string",
      },
      {
        internalType: "bool",
        name: "_preferUnstakedTickets",
        type: "bool",
      },
    ],
    name: "pay",
    outputs: [
      {
        internalType: "uint256",
        name: "fundingCycleId",
        type: "uint256",
      },
    ],
    stateMutability: "payable",
    type: "function",
  },
  {
    inputs: [],
    name: "terminalDirectory",
    outputs: [
      {
        internalType: "contract ITerminalDirectory",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
];

export class ITerminal__factory {
  static readonly abi = _abi;
  static createInterface(): ITerminalInterface {
    return new utils.Interface(_abi) as ITerminalInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): ITerminal {
    return new Contract(address, _abi, signerOrProvider) as ITerminal;
  }
}
