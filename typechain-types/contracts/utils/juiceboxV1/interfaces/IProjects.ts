/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import type {
  BaseContract,
  BigNumber,
  BigNumberish,
  BytesLike,
  CallOverrides,
  ContractTransaction,
  Overrides,
  PopulatedTransaction,
  Signer,
  utils,
} from "ethers";
import type {
  FunctionFragment,
  Result,
  EventFragment,
} from "@ethersproject/abi";
import type { Listener, Provider } from "@ethersproject/providers";
import type {
  TypedEventFilter,
  TypedEvent,
  TypedListener,
  OnEvent,
  PromiseOrValue,
} from "../../../../common";

export interface IProjectsInterface extends utils.Interface {
  functions: {
    "approve(address,uint256)": FunctionFragment;
    "balanceOf(address)": FunctionFragment;
    "challengeExpiryOf(bytes32)": FunctionFragment;
    "claimHandle(bytes32,address,uint256)": FunctionFragment;
    "count()": FunctionFragment;
    "create(address,bytes32,string,address)": FunctionFragment;
    "exists(uint256)": FunctionFragment;
    "getApproved(uint256)": FunctionFragment;
    "handleOf(uint256)": FunctionFragment;
    "isApprovedForAll(address,address)": FunctionFragment;
    "ownerOf(uint256)": FunctionFragment;
    "projectFor(bytes32)": FunctionFragment;
    "safeTransferFrom(address,address,uint256)": FunctionFragment;
    "safeTransferFrom(address,address,uint256,bytes)": FunctionFragment;
    "setApprovalForAll(address,bool)": FunctionFragment;
    "setHandle(uint256,bytes32)": FunctionFragment;
    "setUri(uint256,string)": FunctionFragment;
    "supportsInterface(bytes4)": FunctionFragment;
    "transferAddressFor(bytes32)": FunctionFragment;
    "transferFrom(address,address,uint256)": FunctionFragment;
    "transferHandle(uint256,address,bytes32)": FunctionFragment;
    "uriOf(uint256)": FunctionFragment;
  };

  getFunction(
    nameOrSignatureOrTopic:
      | "approve"
      | "balanceOf"
      | "challengeExpiryOf"
      | "claimHandle"
      | "count"
      | "create"
      | "exists"
      | "getApproved"
      | "handleOf"
      | "isApprovedForAll"
      | "ownerOf"
      | "projectFor"
      | "safeTransferFrom(address,address,uint256)"
      | "safeTransferFrom(address,address,uint256,bytes)"
      | "setApprovalForAll"
      | "setHandle"
      | "setUri"
      | "supportsInterface"
      | "transferAddressFor"
      | "transferFrom"
      | "transferHandle"
      | "uriOf"
  ): FunctionFragment;

  encodeFunctionData(
    functionFragment: "approve",
    values: [PromiseOrValue<string>, PromiseOrValue<BigNumberish>]
  ): string;
  encodeFunctionData(
    functionFragment: "balanceOf",
    values: [PromiseOrValue<string>]
  ): string;
  encodeFunctionData(
    functionFragment: "challengeExpiryOf",
    values: [PromiseOrValue<BytesLike>]
  ): string;
  encodeFunctionData(
    functionFragment: "claimHandle",
    values: [
      PromiseOrValue<BytesLike>,
      PromiseOrValue<string>,
      PromiseOrValue<BigNumberish>
    ]
  ): string;
  encodeFunctionData(functionFragment: "count", values?: undefined): string;
  encodeFunctionData(
    functionFragment: "create",
    values: [
      PromiseOrValue<string>,
      PromiseOrValue<BytesLike>,
      PromiseOrValue<string>,
      PromiseOrValue<string>
    ]
  ): string;
  encodeFunctionData(
    functionFragment: "exists",
    values: [PromiseOrValue<BigNumberish>]
  ): string;
  encodeFunctionData(
    functionFragment: "getApproved",
    values: [PromiseOrValue<BigNumberish>]
  ): string;
  encodeFunctionData(
    functionFragment: "handleOf",
    values: [PromiseOrValue<BigNumberish>]
  ): string;
  encodeFunctionData(
    functionFragment: "isApprovedForAll",
    values: [PromiseOrValue<string>, PromiseOrValue<string>]
  ): string;
  encodeFunctionData(
    functionFragment: "ownerOf",
    values: [PromiseOrValue<BigNumberish>]
  ): string;
  encodeFunctionData(
    functionFragment: "projectFor",
    values: [PromiseOrValue<BytesLike>]
  ): string;
  encodeFunctionData(
    functionFragment: "safeTransferFrom(address,address,uint256)",
    values: [
      PromiseOrValue<string>,
      PromiseOrValue<string>,
      PromiseOrValue<BigNumberish>
    ]
  ): string;
  encodeFunctionData(
    functionFragment: "safeTransferFrom(address,address,uint256,bytes)",
    values: [
      PromiseOrValue<string>,
      PromiseOrValue<string>,
      PromiseOrValue<BigNumberish>,
      PromiseOrValue<BytesLike>
    ]
  ): string;
  encodeFunctionData(
    functionFragment: "setApprovalForAll",
    values: [PromiseOrValue<string>, PromiseOrValue<boolean>]
  ): string;
  encodeFunctionData(
    functionFragment: "setHandle",
    values: [PromiseOrValue<BigNumberish>, PromiseOrValue<BytesLike>]
  ): string;
  encodeFunctionData(
    functionFragment: "setUri",
    values: [PromiseOrValue<BigNumberish>, PromiseOrValue<string>]
  ): string;
  encodeFunctionData(
    functionFragment: "supportsInterface",
    values: [PromiseOrValue<BytesLike>]
  ): string;
  encodeFunctionData(
    functionFragment: "transferAddressFor",
    values: [PromiseOrValue<BytesLike>]
  ): string;
  encodeFunctionData(
    functionFragment: "transferFrom",
    values: [
      PromiseOrValue<string>,
      PromiseOrValue<string>,
      PromiseOrValue<BigNumberish>
    ]
  ): string;
  encodeFunctionData(
    functionFragment: "transferHandle",
    values: [
      PromiseOrValue<BigNumberish>,
      PromiseOrValue<string>,
      PromiseOrValue<BytesLike>
    ]
  ): string;
  encodeFunctionData(
    functionFragment: "uriOf",
    values: [PromiseOrValue<BigNumberish>]
  ): string;

  decodeFunctionResult(functionFragment: "approve", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "balanceOf", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "challengeExpiryOf",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "claimHandle",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "count", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "create", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "exists", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "getApproved",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "handleOf", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "isApprovedForAll",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "ownerOf", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "projectFor", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "safeTransferFrom(address,address,uint256)",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "safeTransferFrom(address,address,uint256,bytes)",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "setApprovalForAll",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "setHandle", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "setUri", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "supportsInterface",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "transferAddressFor",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "transferFrom",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "transferHandle",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "uriOf", data: BytesLike): Result;

  events: {
    "Approval(address,address,uint256)": EventFragment;
    "ApprovalForAll(address,address,bool)": EventFragment;
    "ChallengeHandle(bytes32,uint256,address)": EventFragment;
    "ClaimHandle(address,uint256,bytes32,address)": EventFragment;
    "Create(uint256,address,bytes32,string,address,address)": EventFragment;
    "RenewHandle(bytes32,uint256,address)": EventFragment;
    "SetHandle(uint256,bytes32,address)": EventFragment;
    "SetUri(uint256,string,address)": EventFragment;
    "Transfer(address,address,uint256)": EventFragment;
    "TransferHandle(uint256,address,bytes32,bytes32,address)": EventFragment;
  };

  getEvent(nameOrSignatureOrTopic: "Approval"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "ApprovalForAll"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "ChallengeHandle"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "ClaimHandle"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "Create"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "RenewHandle"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "SetHandle"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "SetUri"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "Transfer"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "TransferHandle"): EventFragment;
}

export interface ApprovalEventObject {
  owner: string;
  approved: string;
  tokenId: BigNumber;
}
export type ApprovalEvent = TypedEvent<
  [string, string, BigNumber],
  ApprovalEventObject
>;

export type ApprovalEventFilter = TypedEventFilter<ApprovalEvent>;

export interface ApprovalForAllEventObject {
  owner: string;
  operator: string;
  approved: boolean;
}
export type ApprovalForAllEvent = TypedEvent<
  [string, string, boolean],
  ApprovalForAllEventObject
>;

export type ApprovalForAllEventFilter = TypedEventFilter<ApprovalForAllEvent>;

export interface ChallengeHandleEventObject {
  handle: string;
  challengeExpiry: BigNumber;
  caller: string;
}
export type ChallengeHandleEvent = TypedEvent<
  [string, BigNumber, string],
  ChallengeHandleEventObject
>;

export type ChallengeHandleEventFilter = TypedEventFilter<ChallengeHandleEvent>;

export interface ClaimHandleEventObject {
  account: string;
  projectId: BigNumber;
  handle: string;
  caller: string;
}
export type ClaimHandleEvent = TypedEvent<
  [string, BigNumber, string, string],
  ClaimHandleEventObject
>;

export type ClaimHandleEventFilter = TypedEventFilter<ClaimHandleEvent>;

export interface CreateEventObject {
  projectId: BigNumber;
  owner: string;
  handle: string;
  uri: string;
  terminal: string;
  caller: string;
}
export type CreateEvent = TypedEvent<
  [BigNumber, string, string, string, string, string],
  CreateEventObject
>;

export type CreateEventFilter = TypedEventFilter<CreateEvent>;

export interface RenewHandleEventObject {
  handle: string;
  projectId: BigNumber;
  caller: string;
}
export type RenewHandleEvent = TypedEvent<
  [string, BigNumber, string],
  RenewHandleEventObject
>;

export type RenewHandleEventFilter = TypedEventFilter<RenewHandleEvent>;

export interface SetHandleEventObject {
  projectId: BigNumber;
  handle: string;
  caller: string;
}
export type SetHandleEvent = TypedEvent<
  [BigNumber, string, string],
  SetHandleEventObject
>;

export type SetHandleEventFilter = TypedEventFilter<SetHandleEvent>;

export interface SetUriEventObject {
  projectId: BigNumber;
  uri: string;
  caller: string;
}
export type SetUriEvent = TypedEvent<
  [BigNumber, string, string],
  SetUriEventObject
>;

export type SetUriEventFilter = TypedEventFilter<SetUriEvent>;

export interface TransferEventObject {
  from: string;
  to: string;
  tokenId: BigNumber;
}
export type TransferEvent = TypedEvent<
  [string, string, BigNumber],
  TransferEventObject
>;

export type TransferEventFilter = TypedEventFilter<TransferEvent>;

export interface TransferHandleEventObject {
  projectId: BigNumber;
  to: string;
  handle: string;
  newHandle: string;
  caller: string;
}
export type TransferHandleEvent = TypedEvent<
  [BigNumber, string, string, string, string],
  TransferHandleEventObject
>;

export type TransferHandleEventFilter = TypedEventFilter<TransferHandleEvent>;

export interface IProjects extends BaseContract {
  connect(signerOrProvider: Signer | Provider | string): this;
  attach(addressOrName: string): this;
  deployed(): Promise<this>;

  interface: IProjectsInterface;

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
    approve(
      to: PromiseOrValue<string>,
      tokenId: PromiseOrValue<BigNumberish>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    balanceOf(
      owner: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<[BigNumber] & { balance: BigNumber }>;

    challengeExpiryOf(
      _handle: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    claimHandle(
      _handle: PromiseOrValue<BytesLike>,
      _for: PromiseOrValue<string>,
      _projectId: PromiseOrValue<BigNumberish>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    count(overrides?: CallOverrides): Promise<[BigNumber]>;

    create(
      _owner: PromiseOrValue<string>,
      _handle: PromiseOrValue<BytesLike>,
      _uri: PromiseOrValue<string>,
      _terminal: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    exists(
      _projectId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<[boolean]>;

    getApproved(
      tokenId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<[string] & { operator: string }>;

    handleOf(
      _projectId: PromiseOrValue<BigNumberish>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    isApprovedForAll(
      owner: PromiseOrValue<string>,
      operator: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<[boolean]>;

    ownerOf(
      tokenId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<[string] & { owner: string }>;

    projectFor(
      _handle: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    "safeTransferFrom(address,address,uint256)"(
      from: PromiseOrValue<string>,
      to: PromiseOrValue<string>,
      tokenId: PromiseOrValue<BigNumberish>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    "safeTransferFrom(address,address,uint256,bytes)"(
      from: PromiseOrValue<string>,
      to: PromiseOrValue<string>,
      tokenId: PromiseOrValue<BigNumberish>,
      data: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    setApprovalForAll(
      operator: PromiseOrValue<string>,
      _approved: PromiseOrValue<boolean>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    setHandle(
      _projectId: PromiseOrValue<BigNumberish>,
      _handle: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    setUri(
      _projectId: PromiseOrValue<BigNumberish>,
      _uri: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    supportsInterface(
      interfaceId: PromiseOrValue<BytesLike>,
      overrides?: CallOverrides
    ): Promise<[boolean]>;

    transferAddressFor(
      _handle: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    transferFrom(
      from: PromiseOrValue<string>,
      to: PromiseOrValue<string>,
      tokenId: PromiseOrValue<BigNumberish>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    transferHandle(
      _projectId: PromiseOrValue<BigNumberish>,
      _to: PromiseOrValue<string>,
      _newHandle: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    uriOf(
      _projectId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<[string]>;
  };

  approve(
    to: PromiseOrValue<string>,
    tokenId: PromiseOrValue<BigNumberish>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  balanceOf(
    owner: PromiseOrValue<string>,
    overrides?: CallOverrides
  ): Promise<BigNumber>;

  challengeExpiryOf(
    _handle: PromiseOrValue<BytesLike>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  claimHandle(
    _handle: PromiseOrValue<BytesLike>,
    _for: PromiseOrValue<string>,
    _projectId: PromiseOrValue<BigNumberish>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  count(overrides?: CallOverrides): Promise<BigNumber>;

  create(
    _owner: PromiseOrValue<string>,
    _handle: PromiseOrValue<BytesLike>,
    _uri: PromiseOrValue<string>,
    _terminal: PromiseOrValue<string>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  exists(
    _projectId: PromiseOrValue<BigNumberish>,
    overrides?: CallOverrides
  ): Promise<boolean>;

  getApproved(
    tokenId: PromiseOrValue<BigNumberish>,
    overrides?: CallOverrides
  ): Promise<string>;

  handleOf(
    _projectId: PromiseOrValue<BigNumberish>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  isApprovedForAll(
    owner: PromiseOrValue<string>,
    operator: PromiseOrValue<string>,
    overrides?: CallOverrides
  ): Promise<boolean>;

  ownerOf(
    tokenId: PromiseOrValue<BigNumberish>,
    overrides?: CallOverrides
  ): Promise<string>;

  projectFor(
    _handle: PromiseOrValue<BytesLike>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  "safeTransferFrom(address,address,uint256)"(
    from: PromiseOrValue<string>,
    to: PromiseOrValue<string>,
    tokenId: PromiseOrValue<BigNumberish>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  "safeTransferFrom(address,address,uint256,bytes)"(
    from: PromiseOrValue<string>,
    to: PromiseOrValue<string>,
    tokenId: PromiseOrValue<BigNumberish>,
    data: PromiseOrValue<BytesLike>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  setApprovalForAll(
    operator: PromiseOrValue<string>,
    _approved: PromiseOrValue<boolean>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  setHandle(
    _projectId: PromiseOrValue<BigNumberish>,
    _handle: PromiseOrValue<BytesLike>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  setUri(
    _projectId: PromiseOrValue<BigNumberish>,
    _uri: PromiseOrValue<string>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  supportsInterface(
    interfaceId: PromiseOrValue<BytesLike>,
    overrides?: CallOverrides
  ): Promise<boolean>;

  transferAddressFor(
    _handle: PromiseOrValue<BytesLike>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  transferFrom(
    from: PromiseOrValue<string>,
    to: PromiseOrValue<string>,
    tokenId: PromiseOrValue<BigNumberish>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  transferHandle(
    _projectId: PromiseOrValue<BigNumberish>,
    _to: PromiseOrValue<string>,
    _newHandle: PromiseOrValue<BytesLike>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  uriOf(
    _projectId: PromiseOrValue<BigNumberish>,
    overrides?: CallOverrides
  ): Promise<string>;

  callStatic: {
    approve(
      to: PromiseOrValue<string>,
      tokenId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<void>;

    balanceOf(
      owner: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    challengeExpiryOf(
      _handle: PromiseOrValue<BytesLike>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    claimHandle(
      _handle: PromiseOrValue<BytesLike>,
      _for: PromiseOrValue<string>,
      _projectId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<void>;

    count(overrides?: CallOverrides): Promise<BigNumber>;

    create(
      _owner: PromiseOrValue<string>,
      _handle: PromiseOrValue<BytesLike>,
      _uri: PromiseOrValue<string>,
      _terminal: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    exists(
      _projectId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<boolean>;

    getApproved(
      tokenId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<string>;

    handleOf(
      _projectId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<string>;

    isApprovedForAll(
      owner: PromiseOrValue<string>,
      operator: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<boolean>;

    ownerOf(
      tokenId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<string>;

    projectFor(
      _handle: PromiseOrValue<BytesLike>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    "safeTransferFrom(address,address,uint256)"(
      from: PromiseOrValue<string>,
      to: PromiseOrValue<string>,
      tokenId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<void>;

    "safeTransferFrom(address,address,uint256,bytes)"(
      from: PromiseOrValue<string>,
      to: PromiseOrValue<string>,
      tokenId: PromiseOrValue<BigNumberish>,
      data: PromiseOrValue<BytesLike>,
      overrides?: CallOverrides
    ): Promise<void>;

    setApprovalForAll(
      operator: PromiseOrValue<string>,
      _approved: PromiseOrValue<boolean>,
      overrides?: CallOverrides
    ): Promise<void>;

    setHandle(
      _projectId: PromiseOrValue<BigNumberish>,
      _handle: PromiseOrValue<BytesLike>,
      overrides?: CallOverrides
    ): Promise<void>;

    setUri(
      _projectId: PromiseOrValue<BigNumberish>,
      _uri: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<void>;

    supportsInterface(
      interfaceId: PromiseOrValue<BytesLike>,
      overrides?: CallOverrides
    ): Promise<boolean>;

    transferAddressFor(
      _handle: PromiseOrValue<BytesLike>,
      overrides?: CallOverrides
    ): Promise<string>;

    transferFrom(
      from: PromiseOrValue<string>,
      to: PromiseOrValue<string>,
      tokenId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<void>;

    transferHandle(
      _projectId: PromiseOrValue<BigNumberish>,
      _to: PromiseOrValue<string>,
      _newHandle: PromiseOrValue<BytesLike>,
      overrides?: CallOverrides
    ): Promise<string>;

    uriOf(
      _projectId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<string>;
  };

  filters: {
    "Approval(address,address,uint256)"(
      owner?: PromiseOrValue<string> | null,
      approved?: PromiseOrValue<string> | null,
      tokenId?: PromiseOrValue<BigNumberish> | null
    ): ApprovalEventFilter;
    Approval(
      owner?: PromiseOrValue<string> | null,
      approved?: PromiseOrValue<string> | null,
      tokenId?: PromiseOrValue<BigNumberish> | null
    ): ApprovalEventFilter;

    "ApprovalForAll(address,address,bool)"(
      owner?: PromiseOrValue<string> | null,
      operator?: PromiseOrValue<string> | null,
      approved?: null
    ): ApprovalForAllEventFilter;
    ApprovalForAll(
      owner?: PromiseOrValue<string> | null,
      operator?: PromiseOrValue<string> | null,
      approved?: null
    ): ApprovalForAllEventFilter;

    "ChallengeHandle(bytes32,uint256,address)"(
      handle?: PromiseOrValue<BytesLike> | null,
      challengeExpiry?: null,
      caller?: null
    ): ChallengeHandleEventFilter;
    ChallengeHandle(
      handle?: PromiseOrValue<BytesLike> | null,
      challengeExpiry?: null,
      caller?: null
    ): ChallengeHandleEventFilter;

    "ClaimHandle(address,uint256,bytes32,address)"(
      account?: PromiseOrValue<string> | null,
      projectId?: PromiseOrValue<BigNumberish> | null,
      handle?: PromiseOrValue<BytesLike> | null,
      caller?: null
    ): ClaimHandleEventFilter;
    ClaimHandle(
      account?: PromiseOrValue<string> | null,
      projectId?: PromiseOrValue<BigNumberish> | null,
      handle?: PromiseOrValue<BytesLike> | null,
      caller?: null
    ): ClaimHandleEventFilter;

    "Create(uint256,address,bytes32,string,address,address)"(
      projectId?: PromiseOrValue<BigNumberish> | null,
      owner?: PromiseOrValue<string> | null,
      handle?: PromiseOrValue<BytesLike> | null,
      uri?: null,
      terminal?: null,
      caller?: null
    ): CreateEventFilter;
    Create(
      projectId?: PromiseOrValue<BigNumberish> | null,
      owner?: PromiseOrValue<string> | null,
      handle?: PromiseOrValue<BytesLike> | null,
      uri?: null,
      terminal?: null,
      caller?: null
    ): CreateEventFilter;

    "RenewHandle(bytes32,uint256,address)"(
      handle?: PromiseOrValue<BytesLike> | null,
      projectId?: PromiseOrValue<BigNumberish> | null,
      caller?: null
    ): RenewHandleEventFilter;
    RenewHandle(
      handle?: PromiseOrValue<BytesLike> | null,
      projectId?: PromiseOrValue<BigNumberish> | null,
      caller?: null
    ): RenewHandleEventFilter;

    "SetHandle(uint256,bytes32,address)"(
      projectId?: PromiseOrValue<BigNumberish> | null,
      handle?: PromiseOrValue<BytesLike> | null,
      caller?: null
    ): SetHandleEventFilter;
    SetHandle(
      projectId?: PromiseOrValue<BigNumberish> | null,
      handle?: PromiseOrValue<BytesLike> | null,
      caller?: null
    ): SetHandleEventFilter;

    "SetUri(uint256,string,address)"(
      projectId?: PromiseOrValue<BigNumberish> | null,
      uri?: null,
      caller?: null
    ): SetUriEventFilter;
    SetUri(
      projectId?: PromiseOrValue<BigNumberish> | null,
      uri?: null,
      caller?: null
    ): SetUriEventFilter;

    "Transfer(address,address,uint256)"(
      from?: PromiseOrValue<string> | null,
      to?: PromiseOrValue<string> | null,
      tokenId?: PromiseOrValue<BigNumberish> | null
    ): TransferEventFilter;
    Transfer(
      from?: PromiseOrValue<string> | null,
      to?: PromiseOrValue<string> | null,
      tokenId?: PromiseOrValue<BigNumberish> | null
    ): TransferEventFilter;

    "TransferHandle(uint256,address,bytes32,bytes32,address)"(
      projectId?: PromiseOrValue<BigNumberish> | null,
      to?: PromiseOrValue<string> | null,
      handle?: PromiseOrValue<BytesLike> | null,
      newHandle?: null,
      caller?: null
    ): TransferHandleEventFilter;
    TransferHandle(
      projectId?: PromiseOrValue<BigNumberish> | null,
      to?: PromiseOrValue<string> | null,
      handle?: PromiseOrValue<BytesLike> | null,
      newHandle?: null,
      caller?: null
    ): TransferHandleEventFilter;
  };

  estimateGas: {
    approve(
      to: PromiseOrValue<string>,
      tokenId: PromiseOrValue<BigNumberish>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    balanceOf(
      owner: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    challengeExpiryOf(
      _handle: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    claimHandle(
      _handle: PromiseOrValue<BytesLike>,
      _for: PromiseOrValue<string>,
      _projectId: PromiseOrValue<BigNumberish>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    count(overrides?: CallOverrides): Promise<BigNumber>;

    create(
      _owner: PromiseOrValue<string>,
      _handle: PromiseOrValue<BytesLike>,
      _uri: PromiseOrValue<string>,
      _terminal: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    exists(
      _projectId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    getApproved(
      tokenId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    handleOf(
      _projectId: PromiseOrValue<BigNumberish>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    isApprovedForAll(
      owner: PromiseOrValue<string>,
      operator: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    ownerOf(
      tokenId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    projectFor(
      _handle: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    "safeTransferFrom(address,address,uint256)"(
      from: PromiseOrValue<string>,
      to: PromiseOrValue<string>,
      tokenId: PromiseOrValue<BigNumberish>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    "safeTransferFrom(address,address,uint256,bytes)"(
      from: PromiseOrValue<string>,
      to: PromiseOrValue<string>,
      tokenId: PromiseOrValue<BigNumberish>,
      data: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    setApprovalForAll(
      operator: PromiseOrValue<string>,
      _approved: PromiseOrValue<boolean>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    setHandle(
      _projectId: PromiseOrValue<BigNumberish>,
      _handle: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    setUri(
      _projectId: PromiseOrValue<BigNumberish>,
      _uri: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    supportsInterface(
      interfaceId: PromiseOrValue<BytesLike>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    transferAddressFor(
      _handle: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    transferFrom(
      from: PromiseOrValue<string>,
      to: PromiseOrValue<string>,
      tokenId: PromiseOrValue<BigNumberish>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    transferHandle(
      _projectId: PromiseOrValue<BigNumberish>,
      _to: PromiseOrValue<string>,
      _newHandle: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    uriOf(
      _projectId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;
  };

  populateTransaction: {
    approve(
      to: PromiseOrValue<string>,
      tokenId: PromiseOrValue<BigNumberish>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    balanceOf(
      owner: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    challengeExpiryOf(
      _handle: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    claimHandle(
      _handle: PromiseOrValue<BytesLike>,
      _for: PromiseOrValue<string>,
      _projectId: PromiseOrValue<BigNumberish>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    count(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    create(
      _owner: PromiseOrValue<string>,
      _handle: PromiseOrValue<BytesLike>,
      _uri: PromiseOrValue<string>,
      _terminal: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    exists(
      _projectId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    getApproved(
      tokenId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    handleOf(
      _projectId: PromiseOrValue<BigNumberish>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    isApprovedForAll(
      owner: PromiseOrValue<string>,
      operator: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    ownerOf(
      tokenId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    projectFor(
      _handle: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    "safeTransferFrom(address,address,uint256)"(
      from: PromiseOrValue<string>,
      to: PromiseOrValue<string>,
      tokenId: PromiseOrValue<BigNumberish>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    "safeTransferFrom(address,address,uint256,bytes)"(
      from: PromiseOrValue<string>,
      to: PromiseOrValue<string>,
      tokenId: PromiseOrValue<BigNumberish>,
      data: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    setApprovalForAll(
      operator: PromiseOrValue<string>,
      _approved: PromiseOrValue<boolean>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    setHandle(
      _projectId: PromiseOrValue<BigNumberish>,
      _handle: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    setUri(
      _projectId: PromiseOrValue<BigNumberish>,
      _uri: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    supportsInterface(
      interfaceId: PromiseOrValue<BytesLike>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    transferAddressFor(
      _handle: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    transferFrom(
      from: PromiseOrValue<string>,
      to: PromiseOrValue<string>,
      tokenId: PromiseOrValue<BigNumberish>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    transferHandle(
      _projectId: PromiseOrValue<BigNumberish>,
      _to: PromiseOrValue<string>,
      _newHandle: PromiseOrValue<BytesLike>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    uriOf(
      _projectId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;
  };
}