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
  PayableOverrides,
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
} from "../../../common";

export type SubSlicerProductStruct = {
  subSlicerId: PromiseOrValue<BigNumberish>;
  subProductId: PromiseOrValue<BigNumberish>;
};

export type SubSlicerProductStructOutput = [BigNumber, number] & {
  subSlicerId: BigNumber;
  subProductId: number;
};

export type CurrencyPriceStruct = {
  value: PromiseOrValue<BigNumberish>;
  dynamicPricing: PromiseOrValue<boolean>;
  currency: PromiseOrValue<string>;
};

export type CurrencyPriceStructOutput = [BigNumber, boolean, string] & {
  value: BigNumber;
  dynamicPricing: boolean;
  currency: string;
};

export type FunctionStruct = {
  data: PromiseOrValue<BytesLike>;
  value: PromiseOrValue<BigNumberish>;
  externalAddress: PromiseOrValue<string>;
  checkFunctionSignature: PromiseOrValue<BytesLike>;
  execFunctionSignature: PromiseOrValue<BytesLike>;
};

export type FunctionStructOutput = [
  string,
  BigNumber,
  string,
  string,
  string
] & {
  data: string;
  value: BigNumber;
  externalAddress: string;
  checkFunctionSignature: string;
  execFunctionSignature: string;
};

export type ProductParamsStruct = {
  subSlicerProducts: SubSlicerProductStruct[];
  currencyPrices: CurrencyPriceStruct[];
  data: PromiseOrValue<BytesLike>;
  purchaseData: PromiseOrValue<BytesLike>;
  availableUnits: PromiseOrValue<BigNumberish>;
  maxUnitsPerBuyer: PromiseOrValue<BigNumberish>;
  isFree: PromiseOrValue<boolean>;
  isInfinite: PromiseOrValue<boolean>;
};

export type ProductParamsStructOutput = [
  SubSlicerProductStructOutput[],
  CurrencyPriceStructOutput[],
  string,
  string,
  number,
  number,
  boolean,
  boolean
] & {
  subSlicerProducts: SubSlicerProductStructOutput[];
  currencyPrices: CurrencyPriceStructOutput[];
  data: string;
  purchaseData: string;
  availableUnits: number;
  maxUnitsPerBuyer: number;
  isFree: boolean;
  isInfinite: boolean;
};

export type PurchaseParamsStruct = {
  slicerId: PromiseOrValue<BigNumberish>;
  quantity: PromiseOrValue<BigNumberish>;
  currency: PromiseOrValue<string>;
  productId: PromiseOrValue<BigNumberish>;
  buyerCustomData: PromiseOrValue<BytesLike>;
};

export type PurchaseParamsStructOutput = [
  BigNumber,
  number,
  string,
  number,
  string
] & {
  slicerId: BigNumber;
  quantity: number;
  currency: string;
  productId: number;
  buyerCustomData: string;
};

export interface ProductsModuleInterface extends utils.Interface {
  functions: {
    "_togglePause()": FunctionFragment;
    "addProduct(uint256,((uint128,uint32)[],(uint248,bool,address)[],bytes,bytes,uint32,uint8,bool,bool),(bytes,uint256,address,bytes4,bytes4))": FunctionFragment;
    "ethBalance(uint256)": FunctionFragment;
    "initialize()": FunctionFragment;
    "owner()": FunctionFragment;
    "paused()": FunctionFragment;
    "payProducts(address,(uint128,uint32,address,uint32,bytes)[])": FunctionFragment;
    "productPrice(uint256,uint32,address)": FunctionFragment;
    "proxiableUUID()": FunctionFragment;
    "releaseEthToSlicer(uint256)": FunctionFragment;
    "removeProduct(uint256,uint32)": FunctionFragment;
    "renounceOwnership()": FunctionFragment;
    "setProductInfo(uint256,uint32,uint8,bool,bool,uint32,(uint248,bool,address)[])": FunctionFragment;
    "transferOwnership(address)": FunctionFragment;
    "upgradeTo(address)": FunctionFragment;
    "upgradeToAndCall(address,bytes)": FunctionFragment;
    "validatePurchase(uint256,uint32)": FunctionFragment;
    "validatePurchaseUnits(address,uint256,uint32)": FunctionFragment;
  };

  getFunction(
    nameOrSignatureOrTopic:
      | "_togglePause"
      | "addProduct"
      | "ethBalance"
      | "initialize"
      | "owner"
      | "paused"
      | "payProducts"
      | "productPrice"
      | "proxiableUUID"
      | "releaseEthToSlicer"
      | "removeProduct"
      | "renounceOwnership"
      | "setProductInfo"
      | "transferOwnership"
      | "upgradeTo"
      | "upgradeToAndCall"
      | "validatePurchase"
      | "validatePurchaseUnits"
  ): FunctionFragment;

  encodeFunctionData(
    functionFragment: "_togglePause",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "addProduct",
    values: [PromiseOrValue<BigNumberish>, ProductParamsStruct, FunctionStruct]
  ): string;
  encodeFunctionData(
    functionFragment: "ethBalance",
    values: [PromiseOrValue<BigNumberish>]
  ): string;
  encodeFunctionData(
    functionFragment: "initialize",
    values?: undefined
  ): string;
  encodeFunctionData(functionFragment: "owner", values?: undefined): string;
  encodeFunctionData(functionFragment: "paused", values?: undefined): string;
  encodeFunctionData(
    functionFragment: "payProducts",
    values: [PromiseOrValue<string>, PurchaseParamsStruct[]]
  ): string;
  encodeFunctionData(
    functionFragment: "productPrice",
    values: [
      PromiseOrValue<BigNumberish>,
      PromiseOrValue<BigNumberish>,
      PromiseOrValue<string>
    ]
  ): string;
  encodeFunctionData(
    functionFragment: "proxiableUUID",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "releaseEthToSlicer",
    values: [PromiseOrValue<BigNumberish>]
  ): string;
  encodeFunctionData(
    functionFragment: "removeProduct",
    values: [PromiseOrValue<BigNumberish>, PromiseOrValue<BigNumberish>]
  ): string;
  encodeFunctionData(
    functionFragment: "renounceOwnership",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "setProductInfo",
    values: [
      PromiseOrValue<BigNumberish>,
      PromiseOrValue<BigNumberish>,
      PromiseOrValue<BigNumberish>,
      PromiseOrValue<boolean>,
      PromiseOrValue<boolean>,
      PromiseOrValue<BigNumberish>,
      CurrencyPriceStruct[]
    ]
  ): string;
  encodeFunctionData(
    functionFragment: "transferOwnership",
    values: [PromiseOrValue<string>]
  ): string;
  encodeFunctionData(
    functionFragment: "upgradeTo",
    values: [PromiseOrValue<string>]
  ): string;
  encodeFunctionData(
    functionFragment: "upgradeToAndCall",
    values: [PromiseOrValue<string>, PromiseOrValue<BytesLike>]
  ): string;
  encodeFunctionData(
    functionFragment: "validatePurchase",
    values: [PromiseOrValue<BigNumberish>, PromiseOrValue<BigNumberish>]
  ): string;
  encodeFunctionData(
    functionFragment: "validatePurchaseUnits",
    values: [
      PromiseOrValue<string>,
      PromiseOrValue<BigNumberish>,
      PromiseOrValue<BigNumberish>
    ]
  ): string;

  decodeFunctionResult(
    functionFragment: "_togglePause",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "addProduct", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "ethBalance", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "initialize", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "owner", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "paused", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "payProducts",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "productPrice",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "proxiableUUID",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "releaseEthToSlicer",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "removeProduct",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "renounceOwnership",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "setProductInfo",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "transferOwnership",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "upgradeTo", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "upgradeToAndCall",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "validatePurchase",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "validatePurchaseUnits",
    data: BytesLike
  ): Result;

  events: {
    "AdminChanged(address,address)": EventFragment;
    "BeaconUpgraded(address)": EventFragment;
    "ERC1155ListingChanged(uint256,address,uint256,uint256)": EventFragment;
    "ERC721ListingChanged(uint256,address,uint256,bool)": EventFragment;
    "Initialized(uint8)": EventFragment;
    "OwnershipTransferred(address,address)": EventFragment;
    "Paused(address)": EventFragment;
    "ProductAdded(uint256,uint256,uint256,bool,uint8,bool,uint256,address,bytes,tuple[],tuple[],tuple)": EventFragment;
    "ProductInfoChanged(uint256,uint256,uint8,bool,bool,uint256,tuple[])": EventFragment;
    "ProductPaid(uint256,uint256,uint256,address,address,uint256,uint256)": EventFragment;
    "ProductRemoved(uint256,uint256)": EventFragment;
    "ReleasedToSlicer(uint256,uint256)": EventFragment;
    "Unpaused(address)": EventFragment;
    "Upgraded(address)": EventFragment;
  };

  getEvent(nameOrSignatureOrTopic: "AdminChanged"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "BeaconUpgraded"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "ERC1155ListingChanged"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "ERC721ListingChanged"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "Initialized"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "OwnershipTransferred"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "Paused"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "ProductAdded"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "ProductInfoChanged"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "ProductPaid"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "ProductRemoved"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "ReleasedToSlicer"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "Unpaused"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "Upgraded"): EventFragment;
}

export interface AdminChangedEventObject {
  previousAdmin: string;
  newAdmin: string;
}
export type AdminChangedEvent = TypedEvent<
  [string, string],
  AdminChangedEventObject
>;

export type AdminChangedEventFilter = TypedEventFilter<AdminChangedEvent>;

export interface BeaconUpgradedEventObject {
  beacon: string;
}
export type BeaconUpgradedEvent = TypedEvent<
  [string],
  BeaconUpgradedEventObject
>;

export type BeaconUpgradedEventFilter = TypedEventFilter<BeaconUpgradedEvent>;

export interface ERC1155ListingChangedEventObject {
  slicerId: BigNumber;
  contractAddress: string;
  tokenId: BigNumber;
  currentAmount: BigNumber;
}
export type ERC1155ListingChangedEvent = TypedEvent<
  [BigNumber, string, BigNumber, BigNumber],
  ERC1155ListingChangedEventObject
>;

export type ERC1155ListingChangedEventFilter =
  TypedEventFilter<ERC1155ListingChangedEvent>;

export interface ERC721ListingChangedEventObject {
  slicerId: BigNumber;
  contractAddress: string;
  tokenId: BigNumber;
  isActive: boolean;
}
export type ERC721ListingChangedEvent = TypedEvent<
  [BigNumber, string, BigNumber, boolean],
  ERC721ListingChangedEventObject
>;

export type ERC721ListingChangedEventFilter =
  TypedEventFilter<ERC721ListingChangedEvent>;

export interface InitializedEventObject {
  version: number;
}
export type InitializedEvent = TypedEvent<[number], InitializedEventObject>;

export type InitializedEventFilter = TypedEventFilter<InitializedEvent>;

export interface OwnershipTransferredEventObject {
  previousOwner: string;
  newOwner: string;
}
export type OwnershipTransferredEvent = TypedEvent<
  [string, string],
  OwnershipTransferredEventObject
>;

export type OwnershipTransferredEventFilter =
  TypedEventFilter<OwnershipTransferredEvent>;

export interface PausedEventObject {
  account: string;
}
export type PausedEvent = TypedEvent<[string], PausedEventObject>;

export type PausedEventFilter = TypedEventFilter<PausedEvent>;

export interface ProductAddedEventObject {
  slicerId: BigNumber;
  productId: BigNumber;
  categoryIndex: BigNumber;
  isFree: boolean;
  maxUnitsPerBuyer: number;
  isInfinite: boolean;
  availableUnits: BigNumber;
  creator: string;
  data: string;
  subSlicerProducts: SubSlicerProductStructOutput[];
  currencyPrices: CurrencyPriceStructOutput[];
  externalCall: FunctionStructOutput;
}
export type ProductAddedEvent = TypedEvent<
  [
    BigNumber,
    BigNumber,
    BigNumber,
    boolean,
    number,
    boolean,
    BigNumber,
    string,
    string,
    SubSlicerProductStructOutput[],
    CurrencyPriceStructOutput[],
    FunctionStructOutput
  ],
  ProductAddedEventObject
>;

export type ProductAddedEventFilter = TypedEventFilter<ProductAddedEvent>;

export interface ProductInfoChangedEventObject {
  slicerId: BigNumber;
  productId: BigNumber;
  maxUnitsPerBuyer: number;
  isFree: boolean;
  isInfinite: boolean;
  newUnits: BigNumber;
  currencyPrices: CurrencyPriceStructOutput[];
}
export type ProductInfoChangedEvent = TypedEvent<
  [
    BigNumber,
    BigNumber,
    number,
    boolean,
    boolean,
    BigNumber,
    CurrencyPriceStructOutput[]
  ],
  ProductInfoChangedEventObject
>;

export type ProductInfoChangedEventFilter =
  TypedEventFilter<ProductInfoChangedEvent>;

export interface ProductPaidEventObject {
  slicerId: BigNumber;
  productId: BigNumber;
  quantity: BigNumber;
  buyer: string;
  currency: string;
  paymentEth: BigNumber;
  paymentCurrency: BigNumber;
}
export type ProductPaidEvent = TypedEvent<
  [BigNumber, BigNumber, BigNumber, string, string, BigNumber, BigNumber],
  ProductPaidEventObject
>;

export type ProductPaidEventFilter = TypedEventFilter<ProductPaidEvent>;

export interface ProductRemovedEventObject {
  slicerId: BigNumber;
  productId: BigNumber;
}
export type ProductRemovedEvent = TypedEvent<
  [BigNumber, BigNumber],
  ProductRemovedEventObject
>;

export type ProductRemovedEventFilter = TypedEventFilter<ProductRemovedEvent>;

export interface ReleasedToSlicerEventObject {
  slicerId: BigNumber;
  ethToRelease: BigNumber;
}
export type ReleasedToSlicerEvent = TypedEvent<
  [BigNumber, BigNumber],
  ReleasedToSlicerEventObject
>;

export type ReleasedToSlicerEventFilter =
  TypedEventFilter<ReleasedToSlicerEvent>;

export interface UnpausedEventObject {
  account: string;
}
export type UnpausedEvent = TypedEvent<[string], UnpausedEventObject>;

export type UnpausedEventFilter = TypedEventFilter<UnpausedEvent>;

export interface UpgradedEventObject {
  implementation: string;
}
export type UpgradedEvent = TypedEvent<[string], UpgradedEventObject>;

export type UpgradedEventFilter = TypedEventFilter<UpgradedEvent>;

export interface ProductsModule extends BaseContract {
  connect(signerOrProvider: Signer | Provider | string): this;
  attach(addressOrName: string): this;
  deployed(): Promise<this>;

  interface: ProductsModuleInterface;

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
    _togglePause(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    addProduct(
      slicerId: PromiseOrValue<BigNumberish>,
      params: ProductParamsStruct,
      externalCall_: FunctionStruct,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    ethBalance(
      slicerId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<[BigNumber]>;

    initialize(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    owner(overrides?: CallOverrides): Promise<[string]>;

    paused(overrides?: CallOverrides): Promise<[boolean]>;

    payProducts(
      buyer: PromiseOrValue<string>,
      purchases: PurchaseParamsStruct[],
      overrides?: PayableOverrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    productPrice(
      slicerId: PromiseOrValue<BigNumberish>,
      productId: PromiseOrValue<BigNumberish>,
      currency: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<
      [BigNumber, BigNumber] & {
        ethPayment: BigNumber;
        currencyPayment: BigNumber;
      }
    >;

    proxiableUUID(overrides?: CallOverrides): Promise<[string]>;

    releaseEthToSlicer(
      slicerId: PromiseOrValue<BigNumberish>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    removeProduct(
      slicerId: PromiseOrValue<BigNumberish>,
      productId: PromiseOrValue<BigNumberish>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    renounceOwnership(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    setProductInfo(
      slicerId: PromiseOrValue<BigNumberish>,
      productId: PromiseOrValue<BigNumberish>,
      newMaxUnits: PromiseOrValue<BigNumberish>,
      isFree: PromiseOrValue<boolean>,
      isInfinite: PromiseOrValue<boolean>,
      newUnits: PromiseOrValue<BigNumberish>,
      currencyPrices: CurrencyPriceStruct[],
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    transferOwnership(
      newOwner: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    upgradeTo(
      newImplementation: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    upgradeToAndCall(
      newImplementation: PromiseOrValue<string>,
      data: PromiseOrValue<BytesLike>,
      overrides?: PayableOverrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    validatePurchase(
      slicerId: PromiseOrValue<BigNumberish>,
      productId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<
      [BigNumber, string] & { purchases: BigNumber; purchaseData: string }
    >;

    validatePurchaseUnits(
      account: PromiseOrValue<string>,
      slicerId: PromiseOrValue<BigNumberish>,
      productId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<[BigNumber] & { purchases: BigNumber }>;
  };

  _togglePause(
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  addProduct(
    slicerId: PromiseOrValue<BigNumberish>,
    params: ProductParamsStruct,
    externalCall_: FunctionStruct,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  ethBalance(
    slicerId: PromiseOrValue<BigNumberish>,
    overrides?: CallOverrides
  ): Promise<BigNumber>;

  initialize(
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  owner(overrides?: CallOverrides): Promise<string>;

  paused(overrides?: CallOverrides): Promise<boolean>;

  payProducts(
    buyer: PromiseOrValue<string>,
    purchases: PurchaseParamsStruct[],
    overrides?: PayableOverrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  productPrice(
    slicerId: PromiseOrValue<BigNumberish>,
    productId: PromiseOrValue<BigNumberish>,
    currency: PromiseOrValue<string>,
    overrides?: CallOverrides
  ): Promise<
    [BigNumber, BigNumber] & {
      ethPayment: BigNumber;
      currencyPayment: BigNumber;
    }
  >;

  proxiableUUID(overrides?: CallOverrides): Promise<string>;

  releaseEthToSlicer(
    slicerId: PromiseOrValue<BigNumberish>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  removeProduct(
    slicerId: PromiseOrValue<BigNumberish>,
    productId: PromiseOrValue<BigNumberish>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  renounceOwnership(
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  setProductInfo(
    slicerId: PromiseOrValue<BigNumberish>,
    productId: PromiseOrValue<BigNumberish>,
    newMaxUnits: PromiseOrValue<BigNumberish>,
    isFree: PromiseOrValue<boolean>,
    isInfinite: PromiseOrValue<boolean>,
    newUnits: PromiseOrValue<BigNumberish>,
    currencyPrices: CurrencyPriceStruct[],
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  transferOwnership(
    newOwner: PromiseOrValue<string>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  upgradeTo(
    newImplementation: PromiseOrValue<string>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  upgradeToAndCall(
    newImplementation: PromiseOrValue<string>,
    data: PromiseOrValue<BytesLike>,
    overrides?: PayableOverrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  validatePurchase(
    slicerId: PromiseOrValue<BigNumberish>,
    productId: PromiseOrValue<BigNumberish>,
    overrides?: CallOverrides
  ): Promise<
    [BigNumber, string] & { purchases: BigNumber; purchaseData: string }
  >;

  validatePurchaseUnits(
    account: PromiseOrValue<string>,
    slicerId: PromiseOrValue<BigNumberish>,
    productId: PromiseOrValue<BigNumberish>,
    overrides?: CallOverrides
  ): Promise<BigNumber>;

  callStatic: {
    _togglePause(overrides?: CallOverrides): Promise<void>;

    addProduct(
      slicerId: PromiseOrValue<BigNumberish>,
      params: ProductParamsStruct,
      externalCall_: FunctionStruct,
      overrides?: CallOverrides
    ): Promise<void>;

    ethBalance(
      slicerId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    initialize(overrides?: CallOverrides): Promise<void>;

    owner(overrides?: CallOverrides): Promise<string>;

    paused(overrides?: CallOverrides): Promise<boolean>;

    payProducts(
      buyer: PromiseOrValue<string>,
      purchases: PurchaseParamsStruct[],
      overrides?: CallOverrides
    ): Promise<void>;

    productPrice(
      slicerId: PromiseOrValue<BigNumberish>,
      productId: PromiseOrValue<BigNumberish>,
      currency: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<
      [BigNumber, BigNumber] & {
        ethPayment: BigNumber;
        currencyPayment: BigNumber;
      }
    >;

    proxiableUUID(overrides?: CallOverrides): Promise<string>;

    releaseEthToSlicer(
      slicerId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<void>;

    removeProduct(
      slicerId: PromiseOrValue<BigNumberish>,
      productId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<void>;

    renounceOwnership(overrides?: CallOverrides): Promise<void>;

    setProductInfo(
      slicerId: PromiseOrValue<BigNumberish>,
      productId: PromiseOrValue<BigNumberish>,
      newMaxUnits: PromiseOrValue<BigNumberish>,
      isFree: PromiseOrValue<boolean>,
      isInfinite: PromiseOrValue<boolean>,
      newUnits: PromiseOrValue<BigNumberish>,
      currencyPrices: CurrencyPriceStruct[],
      overrides?: CallOverrides
    ): Promise<void>;

    transferOwnership(
      newOwner: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<void>;

    upgradeTo(
      newImplementation: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<void>;

    upgradeToAndCall(
      newImplementation: PromiseOrValue<string>,
      data: PromiseOrValue<BytesLike>,
      overrides?: CallOverrides
    ): Promise<void>;

    validatePurchase(
      slicerId: PromiseOrValue<BigNumberish>,
      productId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<
      [BigNumber, string] & { purchases: BigNumber; purchaseData: string }
    >;

    validatePurchaseUnits(
      account: PromiseOrValue<string>,
      slicerId: PromiseOrValue<BigNumberish>,
      productId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;
  };

  filters: {
    "AdminChanged(address,address)"(
      previousAdmin?: null,
      newAdmin?: null
    ): AdminChangedEventFilter;
    AdminChanged(
      previousAdmin?: null,
      newAdmin?: null
    ): AdminChangedEventFilter;

    "BeaconUpgraded(address)"(
      beacon?: PromiseOrValue<string> | null
    ): BeaconUpgradedEventFilter;
    BeaconUpgraded(
      beacon?: PromiseOrValue<string> | null
    ): BeaconUpgradedEventFilter;

    "ERC1155ListingChanged(uint256,address,uint256,uint256)"(
      slicerId?: PromiseOrValue<BigNumberish> | null,
      contractAddress?: PromiseOrValue<string> | null,
      tokenId?: PromiseOrValue<BigNumberish> | null,
      currentAmount?: null
    ): ERC1155ListingChangedEventFilter;
    ERC1155ListingChanged(
      slicerId?: PromiseOrValue<BigNumberish> | null,
      contractAddress?: PromiseOrValue<string> | null,
      tokenId?: PromiseOrValue<BigNumberish> | null,
      currentAmount?: null
    ): ERC1155ListingChangedEventFilter;

    "ERC721ListingChanged(uint256,address,uint256,bool)"(
      slicerId?: PromiseOrValue<BigNumberish> | null,
      contractAddress?: PromiseOrValue<string> | null,
      tokenId?: PromiseOrValue<BigNumberish> | null,
      isActive?: null
    ): ERC721ListingChangedEventFilter;
    ERC721ListingChanged(
      slicerId?: PromiseOrValue<BigNumberish> | null,
      contractAddress?: PromiseOrValue<string> | null,
      tokenId?: PromiseOrValue<BigNumberish> | null,
      isActive?: null
    ): ERC721ListingChangedEventFilter;

    "Initialized(uint8)"(version?: null): InitializedEventFilter;
    Initialized(version?: null): InitializedEventFilter;

    "OwnershipTransferred(address,address)"(
      previousOwner?: PromiseOrValue<string> | null,
      newOwner?: PromiseOrValue<string> | null
    ): OwnershipTransferredEventFilter;
    OwnershipTransferred(
      previousOwner?: PromiseOrValue<string> | null,
      newOwner?: PromiseOrValue<string> | null
    ): OwnershipTransferredEventFilter;

    "Paused(address)"(account?: null): PausedEventFilter;
    Paused(account?: null): PausedEventFilter;

    "ProductAdded(uint256,uint256,uint256,bool,uint8,bool,uint256,address,bytes,tuple[],tuple[],tuple)"(
      slicerId?: PromiseOrValue<BigNumberish> | null,
      productId?: PromiseOrValue<BigNumberish> | null,
      categoryIndex?: PromiseOrValue<BigNumberish> | null,
      isFree?: null,
      maxUnitsPerBuyer?: null,
      isInfinite?: null,
      availableUnits?: null,
      creator?: null,
      data?: null,
      subSlicerProducts?: null,
      currencyPrices?: null,
      externalCall?: null
    ): ProductAddedEventFilter;
    ProductAdded(
      slicerId?: PromiseOrValue<BigNumberish> | null,
      productId?: PromiseOrValue<BigNumberish> | null,
      categoryIndex?: PromiseOrValue<BigNumberish> | null,
      isFree?: null,
      maxUnitsPerBuyer?: null,
      isInfinite?: null,
      availableUnits?: null,
      creator?: null,
      data?: null,
      subSlicerProducts?: null,
      currencyPrices?: null,
      externalCall?: null
    ): ProductAddedEventFilter;

    "ProductInfoChanged(uint256,uint256,uint8,bool,bool,uint256,tuple[])"(
      slicerId?: PromiseOrValue<BigNumberish> | null,
      productId?: PromiseOrValue<BigNumberish> | null,
      maxUnitsPerBuyer?: null,
      isFree?: null,
      isInfinite?: null,
      newUnits?: null,
      currencyPrices?: null
    ): ProductInfoChangedEventFilter;
    ProductInfoChanged(
      slicerId?: PromiseOrValue<BigNumberish> | null,
      productId?: PromiseOrValue<BigNumberish> | null,
      maxUnitsPerBuyer?: null,
      isFree?: null,
      isInfinite?: null,
      newUnits?: null,
      currencyPrices?: null
    ): ProductInfoChangedEventFilter;

    "ProductPaid(uint256,uint256,uint256,address,address,uint256,uint256)"(
      slicerId?: PromiseOrValue<BigNumberish> | null,
      productId?: PromiseOrValue<BigNumberish> | null,
      quantity?: null,
      buyer?: PromiseOrValue<string> | null,
      currency?: null,
      paymentEth?: null,
      paymentCurrency?: null
    ): ProductPaidEventFilter;
    ProductPaid(
      slicerId?: PromiseOrValue<BigNumberish> | null,
      productId?: PromiseOrValue<BigNumberish> | null,
      quantity?: null,
      buyer?: PromiseOrValue<string> | null,
      currency?: null,
      paymentEth?: null,
      paymentCurrency?: null
    ): ProductPaidEventFilter;

    "ProductRemoved(uint256,uint256)"(
      slicerId?: PromiseOrValue<BigNumberish> | null,
      productId?: PromiseOrValue<BigNumberish> | null
    ): ProductRemovedEventFilter;
    ProductRemoved(
      slicerId?: PromiseOrValue<BigNumberish> | null,
      productId?: PromiseOrValue<BigNumberish> | null
    ): ProductRemovedEventFilter;

    "ReleasedToSlicer(uint256,uint256)"(
      slicerId?: PromiseOrValue<BigNumberish> | null,
      ethToRelease?: null
    ): ReleasedToSlicerEventFilter;
    ReleasedToSlicer(
      slicerId?: PromiseOrValue<BigNumberish> | null,
      ethToRelease?: null
    ): ReleasedToSlicerEventFilter;

    "Unpaused(address)"(account?: null): UnpausedEventFilter;
    Unpaused(account?: null): UnpausedEventFilter;

    "Upgraded(address)"(
      implementation?: PromiseOrValue<string> | null
    ): UpgradedEventFilter;
    Upgraded(
      implementation?: PromiseOrValue<string> | null
    ): UpgradedEventFilter;
  };

  estimateGas: {
    _togglePause(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    addProduct(
      slicerId: PromiseOrValue<BigNumberish>,
      params: ProductParamsStruct,
      externalCall_: FunctionStruct,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    ethBalance(
      slicerId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    initialize(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    owner(overrides?: CallOverrides): Promise<BigNumber>;

    paused(overrides?: CallOverrides): Promise<BigNumber>;

    payProducts(
      buyer: PromiseOrValue<string>,
      purchases: PurchaseParamsStruct[],
      overrides?: PayableOverrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    productPrice(
      slicerId: PromiseOrValue<BigNumberish>,
      productId: PromiseOrValue<BigNumberish>,
      currency: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    proxiableUUID(overrides?: CallOverrides): Promise<BigNumber>;

    releaseEthToSlicer(
      slicerId: PromiseOrValue<BigNumberish>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    removeProduct(
      slicerId: PromiseOrValue<BigNumberish>,
      productId: PromiseOrValue<BigNumberish>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    renounceOwnership(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    setProductInfo(
      slicerId: PromiseOrValue<BigNumberish>,
      productId: PromiseOrValue<BigNumberish>,
      newMaxUnits: PromiseOrValue<BigNumberish>,
      isFree: PromiseOrValue<boolean>,
      isInfinite: PromiseOrValue<boolean>,
      newUnits: PromiseOrValue<BigNumberish>,
      currencyPrices: CurrencyPriceStruct[],
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    transferOwnership(
      newOwner: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    upgradeTo(
      newImplementation: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    upgradeToAndCall(
      newImplementation: PromiseOrValue<string>,
      data: PromiseOrValue<BytesLike>,
      overrides?: PayableOverrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    validatePurchase(
      slicerId: PromiseOrValue<BigNumberish>,
      productId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    validatePurchaseUnits(
      account: PromiseOrValue<string>,
      slicerId: PromiseOrValue<BigNumberish>,
      productId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;
  };

  populateTransaction: {
    _togglePause(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    addProduct(
      slicerId: PromiseOrValue<BigNumberish>,
      params: ProductParamsStruct,
      externalCall_: FunctionStruct,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    ethBalance(
      slicerId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    initialize(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    owner(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    paused(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    payProducts(
      buyer: PromiseOrValue<string>,
      purchases: PurchaseParamsStruct[],
      overrides?: PayableOverrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    productPrice(
      slicerId: PromiseOrValue<BigNumberish>,
      productId: PromiseOrValue<BigNumberish>,
      currency: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    proxiableUUID(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    releaseEthToSlicer(
      slicerId: PromiseOrValue<BigNumberish>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    removeProduct(
      slicerId: PromiseOrValue<BigNumberish>,
      productId: PromiseOrValue<BigNumberish>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    renounceOwnership(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    setProductInfo(
      slicerId: PromiseOrValue<BigNumberish>,
      productId: PromiseOrValue<BigNumberish>,
      newMaxUnits: PromiseOrValue<BigNumberish>,
      isFree: PromiseOrValue<boolean>,
      isInfinite: PromiseOrValue<boolean>,
      newUnits: PromiseOrValue<BigNumberish>,
      currencyPrices: CurrencyPriceStruct[],
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    transferOwnership(
      newOwner: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    upgradeTo(
      newImplementation: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    upgradeToAndCall(
      newImplementation: PromiseOrValue<string>,
      data: PromiseOrValue<BytesLike>,
      overrides?: PayableOverrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    validatePurchase(
      slicerId: PromiseOrValue<BigNumberish>,
      productId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    validatePurchaseUnits(
      account: PromiseOrValue<string>,
      slicerId: PromiseOrValue<BigNumberish>,
      productId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;
  };
}