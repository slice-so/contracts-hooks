/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import { Signer, utils, Contract, ContractFactory, Overrides } from "ethers";
import type { Provider, TransactionRequest } from "@ethersproject/providers";
import type { PromiseOrValue } from "../../../../../common";
import type {
  AllowlistedFactory,
  AllowlistedFactoryInterface,
} from "../../../../../contracts/hooks/Allowlisted/immutable/AllowlistedFactory";

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
      {
        internalType: "bytes32",
        name: "merkleRoot_",
        type: "bytes32",
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
] as const;

const _bytecode =
  "0x608060405234801561001057600080fd5b50610697806100206000396000f3fe608060405234801561001057600080fd5b506004361061002b5760003560e01c8063e7008afa14610030575b600080fd5b61004361003e3660046100fd565b61005f565b6040516001600160a01b03909116815260200160405180910390f35b6000838383604051610070906100f0565b6001600160a01b03909316835260208301919091526040820152606001604051809103906000f0801580156100a9573d6000803e3d6000fd5b506040516001600160a01b03821681529091507fcf78cf0d6f3d8371e1075c69c492ab4ec5d8cf23a1a239b6a51a1d00be7ca3129060200160405180910390a19392505050565b6105238061013f83390190565b60008060006060848603121561011257600080fd5b83356001600160a01b038116811461012957600080fd5b9560208501359550604090940135939250505056fe608060405234801561001057600080fd5b5060405161052338038061052383398101604081905261002f9161005b565b600080546001600160a01b0319166001600160a01b03949094169390931790925560015560025561009e565b60008060006060848603121561007057600080fd5b83516001600160a01b038116811461008757600080fd5b602085015160409095015190969495509392505050565b610476806100ad6000396000f3fe6080604052600436106100295760003560e01c806395db93681461002e578063a23fffb914610062575b600080fd5b34801561003a57600080fd5b5061004e6100493660046102bf565b610077565b604051901515815260200160405180910390f35b6100756100703660046102bf565b6100e5565b005b6000808280602001905181019061008e919061035d565b6040516bffffffffffffffffffffffff19606089901b1660208201529091506000906034016040516020818303038152906040528051906020012090506100d88260025483610123565b9998505050505050505050565b856100ef81610139565b6100fd878787878787610077565b61011a57604051631eb49d6d60e11b815260040160405180910390fd5b50505050505050565b6000826101308584610189565b14949350505050565b806001541461015b57604051632eafdb6960e01b815260040160405180910390fd5b6000546001600160a01b03163314610186576040516347322d0360e01b815260040160405180910390fd5b50565b600081815b84518110156101ce576101ba828683815181106101ad576101ad610403565b60200260200101516101d6565b9150806101c681610419565b91505061018e565b509392505050565b60008183106101f2576000828152602084905260409020610201565b60008381526020839052604090205b9392505050565b634e487b7160e01b600052604160045260246000fd5b604051601f8201601f1916810167ffffffffffffffff8111828210171561024757610247610208565b604052919050565b600082601f83011261026057600080fd5b813567ffffffffffffffff81111561027a5761027a610208565b61028d601f8201601f191660200161021e565b8181528460208386010111156102a257600080fd5b816020850160208301376000918101602001919091529392505050565b60008060008060008060c087890312156102d857600080fd5b863595506020870135945060408701356001600160a01b03811681146102fd57600080fd5b935060608701359250608087013567ffffffffffffffff8082111561032157600080fd5b61032d8a838b0161024f565b935060a089013591508082111561034357600080fd5b5061035089828a0161024f565b9150509295509295509295565b6000602080838503121561037057600080fd5b825167ffffffffffffffff8082111561038857600080fd5b818501915085601f83011261039c57600080fd5b8151818111156103ae576103ae610208565b8060051b91506103bf84830161021e565b81815291830184019184810190888411156103d957600080fd5b938501935b838510156103f7578451825293850193908501906103de565b98975050505050505050565b634e487b7160e01b600052603260045260246000fd5b60006001820161043957634e487b7160e01b600052601160045260246000fd5b506001019056fea2646970667358221220959dc63cc8fe5ec3c56a7864178ce8a0ba18a4ae777cd58e3948b2478ff3710864736f6c634300080d0033a264697066735822122088bdfc5c3257ba1cdd0b3172d7731af6455450b047d57c6d18d4b77e5025a77864736f6c634300080d0033";

type AllowlistedFactoryConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: AllowlistedFactoryConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class AllowlistedFactory__factory extends ContractFactory {
  constructor(...args: AllowlistedFactoryConstructorParams) {
    if (isSuperArgs(args)) {
      super(...args);
    } else {
      super(_abi, _bytecode, args[0]);
    }
  }

  override deploy(
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<AllowlistedFactory> {
    return super.deploy(overrides || {}) as Promise<AllowlistedFactory>;
  }
  override getDeployTransaction(
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): TransactionRequest {
    return super.getDeployTransaction(overrides || {});
  }
  override attach(address: string): AllowlistedFactory {
    return super.attach(address) as AllowlistedFactory;
  }
  override connect(signer: Signer): AllowlistedFactory__factory {
    return super.connect(signer) as AllowlistedFactory__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): AllowlistedFactoryInterface {
    return new utils.Interface(_abi) as AllowlistedFactoryInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): AllowlistedFactory {
    return new Contract(address, _abi, signerOrProvider) as AllowlistedFactory;
  }
}