/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import { Signer, utils, Contract, ContractFactory, Overrides } from "ethers";
import { Provider, TransactionRequest } from "@ethersproject/providers";
import type { MyHookFactory, MyHookFactoryInterface } from "../MyHookFactory";

const _abi = [
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "address",
        name: "contractAddress",
        type: "address",
      },
    ],
    name: "ContractCreated",
    type: "event",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "productsModuleAddress_",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "slicerId_",
        type: "uint256",
      },
    ],
    name: "deploy",
    outputs: [
      {
        internalType: "address",
        name: "contractAddress",
        type: "address",
      },
    ],
    stateMutability: "nonpayable",
    type: "function",
  },
];

const _bytecode =
  "0x608060405234801561001057600080fd5b5061045a806100206000396000f3fe608060405234801561001057600080fd5b506004361061002b5760003560e01c80634956eaf014610030575b600080fd5b61004361003e3660046100f3565b61005f565b6040516001600160a01b03909116815260200160405180910390f35b6000828260405161006f906100e6565b6001600160a01b0390921682526020820152604001604051809103906000f0801580156100a0573d6000803e3d6000fd5b506040516001600160a01b03821681529091507fcf78cf0d6f3d8371e1075c69c492ab4ec5d8cf23a1a239b6a51a1d00be7ca3129060200160405180910390a192915050565b6102f98061012c83390190565b6000806040838503121561010657600080fd5b82356001600160a01b038116811461011d57600080fd5b94602093909301359350505056fe608060405234801561001057600080fd5b506040516102f93803806102f983398101604081905261002f91610058565b600080546001600160a01b0319166001600160a01b039390931692909217909155600155610092565b6000806040838503121561006b57600080fd5b82516001600160a01b038116811461008257600080fd5b6020939093015192949293505050565b610258806100a16000396000f3fe6080604052600436106100295760003560e01c806395db93681461002e578063a23fffb914610069575b600080fd5b34801561003a57600080fd5b50610055610049366004610184565b50600195945050505050565b604051901515815260200160405180910390f35b61007c610077366004610184565b61007e565b005b8561008881610091565b50505050505050565b80600154146100b357604051632eafdb6960e01b815260040160405180910390fd5b6000546001600160a01b031633146100de576040516347322d0360e01b815260040160405180910390fd5b50565b634e487b7160e01b600052604160045260246000fd5b600082601f83011261010857600080fd5b813567ffffffffffffffff80821115610123576101236100e1565b604051601f8301601f19908116603f0116810190828211818310171561014b5761014b6100e1565b8160405283815286602085880101111561016457600080fd5b836020870160208301376000602085830101528094505050505092915050565b60008060008060008060c0878903121561019d57600080fd5b863595506020870135945060408701356001600160a01b03811681146101c257600080fd5b935060608701359250608087013567ffffffffffffffff808211156101e657600080fd5b6101f28a838b016100f7565b935060a089013591508082111561020857600080fd5b5061021589828a016100f7565b915050929550929550929556fea2646970667358221220a1774aab960b685d5cf3947a0bf91b3bdf7249dfe04095b7ce183b02dc1145df64736f6c634300080d0033a264697066735822122029d7f38770116117b26d01422ea622b66a227b36397f77fe8934dd978eec51c664736f6c634300080d0033";

type MyHookFactoryConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: MyHookFactoryConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class MyHookFactory__factory extends ContractFactory {
  constructor(...args: MyHookFactoryConstructorParams) {
    if (isSuperArgs(args)) {
      super(...args);
    } else {
      super(_abi, _bytecode, args[0]);
    }
    this.contractName = "MyHookFactory";
  }

  deploy(
    overrides?: Overrides & { from?: string | Promise<string> }
  ): Promise<MyHookFactory> {
    return super.deploy(overrides || {}) as Promise<MyHookFactory>;
  }
  getDeployTransaction(
    overrides?: Overrides & { from?: string | Promise<string> }
  ): TransactionRequest {
    return super.getDeployTransaction(overrides || {});
  }
  attach(address: string): MyHookFactory {
    return super.attach(address) as MyHookFactory;
  }
  connect(signer: Signer): MyHookFactory__factory {
    return super.connect(signer) as MyHookFactory__factory;
  }
  static readonly contractName: "MyHookFactory";
  public readonly contractName: "MyHookFactory";
  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): MyHookFactoryInterface {
    return new utils.Interface(_abi) as MyHookFactoryInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): MyHookFactory {
    return new Contract(address, _abi, signerOrProvider) as MyHookFactory;
  }
}