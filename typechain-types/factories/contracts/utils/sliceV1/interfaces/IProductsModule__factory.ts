/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import { Contract, Signer, utils } from "ethers";
import type { Provider } from "@ethersproject/providers";
import type {
  IProductsModule,
  IProductsModuleInterface,
} from "../../../../../contracts/utils/sliceV1/interfaces/IProductsModule";

const _abi = [
  {
    inputs: [
      {
        internalType: "uint256",
        name: "slicerId",
        type: "uint256",
      },
      {
        components: [
          {
            components: [
              {
                internalType: "uint128",
                name: "subSlicerId",
                type: "uint128",
              },
              {
                internalType: "uint32",
                name: "subProductId",
                type: "uint32",
              },
            ],
            internalType: "struct SubSlicerProduct[]",
            name: "subSlicerProducts",
            type: "tuple[]",
          },
          {
            components: [
              {
                internalType: "uint248",
                name: "value",
                type: "uint248",
              },
              {
                internalType: "bool",
                name: "dynamicPricing",
                type: "bool",
              },
              {
                internalType: "address",
                name: "currency",
                type: "address",
              },
            ],
            internalType: "struct CurrencyPrice[]",
            name: "currencyPrices",
            type: "tuple[]",
          },
          {
            internalType: "bytes",
            name: "data",
            type: "bytes",
          },
          {
            internalType: "bytes",
            name: "purchaseData",
            type: "bytes",
          },
          {
            internalType: "uint32",
            name: "availableUnits",
            type: "uint32",
          },
          {
            internalType: "uint8",
            name: "maxUnitsPerBuyer",
            type: "uint8",
          },
          {
            internalType: "bool",
            name: "isFree",
            type: "bool",
          },
          {
            internalType: "bool",
            name: "isInfinite",
            type: "bool",
          },
        ],
        internalType: "struct ProductParams",
        name: "params",
        type: "tuple",
      },
      {
        components: [
          {
            internalType: "bytes",
            name: "data",
            type: "bytes",
          },
          {
            internalType: "uint256",
            name: "value",
            type: "uint256",
          },
          {
            internalType: "address",
            name: "externalAddress",
            type: "address",
          },
          {
            internalType: "bytes4",
            name: "checkFunctionSignature",
            type: "bytes4",
          },
          {
            internalType: "bytes4",
            name: "execFunctionSignature",
            type: "bytes4",
          },
        ],
        internalType: "struct Function",
        name: "externalCall_",
        type: "tuple",
      },
    ],
    name: "addProduct",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "slicerId",
        type: "uint256",
      },
    ],
    name: "ethBalance",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "buyer",
        type: "address",
      },
      {
        components: [
          {
            internalType: "uint128",
            name: "slicerId",
            type: "uint128",
          },
          {
            internalType: "uint32",
            name: "quantity",
            type: "uint32",
          },
          {
            internalType: "address",
            name: "currency",
            type: "address",
          },
          {
            internalType: "uint32",
            name: "productId",
            type: "uint32",
          },
          {
            internalType: "bytes",
            name: "buyerCustomData",
            type: "bytes",
          },
        ],
        internalType: "struct PurchaseParams[]",
        name: "purchases",
        type: "tuple[]",
      },
    ],
    name: "payProducts",
    outputs: [],
    stateMutability: "payable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "slicerId",
        type: "uint256",
      },
      {
        internalType: "uint32",
        name: "productId",
        type: "uint32",
      },
      {
        internalType: "address",
        name: "currency",
        type: "address",
      },
    ],
    name: "productPrice",
    outputs: [
      {
        internalType: "uint256",
        name: "ethPayment",
        type: "uint256",
      },
      {
        internalType: "uint256",
        name: "currencyPayment",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "slicerId",
        type: "uint256",
      },
    ],
    name: "releaseEthToSlicer",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "slicerId",
        type: "uint256",
      },
      {
        internalType: "uint32",
        name: "productId",
        type: "uint32",
      },
    ],
    name: "removeProduct",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "slicerId",
        type: "uint256",
      },
      {
        internalType: "uint32",
        name: "productId",
        type: "uint32",
      },
      {
        internalType: "uint8",
        name: "newMaxUnits",
        type: "uint8",
      },
      {
        internalType: "bool",
        name: "isFree",
        type: "bool",
      },
      {
        internalType: "bool",
        name: "isInfinite",
        type: "bool",
      },
      {
        internalType: "uint32",
        name: "newUnits",
        type: "uint32",
      },
      {
        components: [
          {
            internalType: "uint248",
            name: "value",
            type: "uint248",
          },
          {
            internalType: "bool",
            name: "dynamicPricing",
            type: "bool",
          },
          {
            internalType: "address",
            name: "currency",
            type: "address",
          },
        ],
        internalType: "struct CurrencyPrice[]",
        name: "currencyPrices",
        type: "tuple[]",
      },
    ],
    name: "setProductInfo",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "slicerId",
        type: "uint256",
      },
      {
        internalType: "uint32",
        name: "productId",
        type: "uint32",
      },
    ],
    name: "validatePurchase",
    outputs: [
      {
        internalType: "uint256",
        name: "purchases",
        type: "uint256",
      },
      {
        internalType: "bytes",
        name: "purchaseData",
        type: "bytes",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "account",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "slicerId",
        type: "uint256",
      },
      {
        internalType: "uint32",
        name: "productId",
        type: "uint32",
      },
    ],
    name: "validatePurchaseUnits",
    outputs: [
      {
        internalType: "uint256",
        name: "purchases",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
] as const;

export class IProductsModule__factory {
  static readonly abi = _abi;
  static createInterface(): IProductsModuleInterface {
    return new utils.Interface(_abi) as IProductsModuleInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): IProductsModule {
    return new Contract(address, _abi, signerOrProvider) as IProductsModule;
  }
}