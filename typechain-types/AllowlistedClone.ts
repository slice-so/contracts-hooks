/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import {
  BaseContract,
  BigNumber,
  BigNumberish,
  BytesLike,
  CallOverrides,
  ContractTransaction,
  Overrides,
  PayableOverrides,
  PopulatedTransaction,
  Signer,
  utils,
} from "ethers";
import { FunctionFragment, Result, EventFragment } from "@ethersproject/abi";
import { Listener, Provider } from "@ethersproject/providers";
import { TypedEventFilter, TypedEvent, TypedListener, OnEvent } from "./common";

export interface AllowlistedCloneInterface extends utils.Interface {
  contractName: "AllowlistedClone";
  functions: {
    "initialize(address,uint256,bytes32)": FunctionFragment;
    "isPurchaseAllowed(uint256,uint256,address,uint256,bytes,bytes)": FunctionFragment;
    "onProductPurchase(uint256,uint256,address,uint256,bytes,bytes)": FunctionFragment;
  };

  encodeFunctionData(
    functionFragment: "initialize",
    values: [string, BigNumberish, BytesLike]
  ): string;
  encodeFunctionData(
    functionFragment: "isPurchaseAllowed",
    values: [
      BigNumberish,
      BigNumberish,
      string,
      BigNumberish,
      BytesLike,
      BytesLike
    ]
  ): string;
  encodeFunctionData(
    functionFragment: "onProductPurchase",
    values: [
      BigNumberish,
      BigNumberish,
      string,
      BigNumberish,
      BytesLike,
      BytesLike
    ]
  ): string;

  decodeFunctionResult(functionFragment: "initialize", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "isPurchaseAllowed",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "onProductPurchase",
    data: BytesLike
  ): Result;

  events: {
    "Initialized(uint8)": EventFragment;
  };

  getEvent(nameOrSignatureOrTopic: "Initialized"): EventFragment;
}

export type InitializedEvent = TypedEvent<[number], { version: number }>;

export type InitializedEventFilter = TypedEventFilter<InitializedEvent>;

export interface AllowlistedClone extends BaseContract {
  contractName: "AllowlistedClone";
  connect(signerOrProvider: Signer | Provider | string): this;
  attach(addressOrName: string): this;
  deployed(): Promise<this>;

  interface: AllowlistedCloneInterface;

  queryFilter<TEvent extends TypedEvent>(
    event: TypedEventFilter<TEvent>,
    fromBlockOrBlockhash?: string | number | undefined,
    toBlock?: string | number | undefined
  ): Promise<Array<TEvent>>;

  listeners<TEvent extends TypedEvent>(
    eventFilter?: TypedEventFilter<TEvent>
  ): Array<TypedListener<TEvent>>;
  listeners(eventName?: string): Array<Listener>;
  removeAllListeners<TEvent extends TypedEvent>(
    eventFilter: TypedEventFilter<TEvent>
  ): this;
  removeAllListeners(eventName?: string): this;
  off: OnEvent<this>;
  on: OnEvent<this>;
  once: OnEvent<this>;
  removeListener: OnEvent<this>;

  functions: {
    initialize(
      productsModuleAddress_: string,
      slicerId_: BigNumberish,
      merkleRoot_: BytesLike,
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<ContractTransaction>;

    isPurchaseAllowed(
      arg0: BigNumberish,
      arg1: BigNumberish,
      account: string,
      arg3: BigNumberish,
      arg4: BytesLike,
      buyerCustomData: BytesLike,
      overrides?: CallOverrides
    ): Promise<[boolean] & { isAllowed: boolean }>;

    onProductPurchase(
      slicerId: BigNumberish,
      productId: BigNumberish,
      account: string,
      quantity: BigNumberish,
      slicerCustomData: BytesLike,
      buyerCustomData: BytesLike,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<ContractTransaction>;
  };

  initialize(
    productsModuleAddress_: string,
    slicerId_: BigNumberish,
    merkleRoot_: BytesLike,
    overrides?: Overrides & { from?: string | Promise<string> }
  ): Promise<ContractTransaction>;

  isPurchaseAllowed(
    arg0: BigNumberish,
    arg1: BigNumberish,
    account: string,
    arg3: BigNumberish,
    arg4: BytesLike,
    buyerCustomData: BytesLike,
    overrides?: CallOverrides
  ): Promise<boolean>;

  onProductPurchase(
    slicerId: BigNumberish,
    productId: BigNumberish,
    account: string,
    quantity: BigNumberish,
    slicerCustomData: BytesLike,
    buyerCustomData: BytesLike,
    overrides?: PayableOverrides & { from?: string | Promise<string> }
  ): Promise<ContractTransaction>;

  callStatic: {
    initialize(
      productsModuleAddress_: string,
      slicerId_: BigNumberish,
      merkleRoot_: BytesLike,
      overrides?: CallOverrides
    ): Promise<void>;

    isPurchaseAllowed(
      arg0: BigNumberish,
      arg1: BigNumberish,
      account: string,
      arg3: BigNumberish,
      arg4: BytesLike,
      buyerCustomData: BytesLike,
      overrides?: CallOverrides
    ): Promise<boolean>;

    onProductPurchase(
      slicerId: BigNumberish,
      productId: BigNumberish,
      account: string,
      quantity: BigNumberish,
      slicerCustomData: BytesLike,
      buyerCustomData: BytesLike,
      overrides?: CallOverrides
    ): Promise<void>;
  };

  filters: {
    "Initialized(uint8)"(version?: null): InitializedEventFilter;
    Initialized(version?: null): InitializedEventFilter;
  };

  estimateGas: {
    initialize(
      productsModuleAddress_: string,
      slicerId_: BigNumberish,
      merkleRoot_: BytesLike,
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<BigNumber>;

    isPurchaseAllowed(
      arg0: BigNumberish,
      arg1: BigNumberish,
      account: string,
      arg3: BigNumberish,
      arg4: BytesLike,
      buyerCustomData: BytesLike,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    onProductPurchase(
      slicerId: BigNumberish,
      productId: BigNumberish,
      account: string,
      quantity: BigNumberish,
      slicerCustomData: BytesLike,
      buyerCustomData: BytesLike,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<BigNumber>;
  };

  populateTransaction: {
    initialize(
      productsModuleAddress_: string,
      slicerId_: BigNumberish,
      merkleRoot_: BytesLike,
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<PopulatedTransaction>;

    isPurchaseAllowed(
      arg0: BigNumberish,
      arg1: BigNumberish,
      account: string,
      arg3: BigNumberish,
      arg4: BytesLike,
      buyerCustomData: BytesLike,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    onProductPurchase(
      slicerId: BigNumberish,
      productId: BigNumberish,
      account: string,
      quantity: BigNumberish,
      slicerCustomData: BytesLike,
      buyerCustomData: BytesLike,
      overrides?: PayableOverrides & { from?: string | Promise<string> }
    ): Promise<PopulatedTransaction>;
  };
}