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
} from "../../../common";

export interface TerminalDirectoryInterface extends utils.Interface {
  functions: {
    "addressesOf(uint256)": FunctionFragment;
    "beneficiaryOf(address)": FunctionFragment;
    "deployAddress(uint256,string)": FunctionFragment;
    "operatorStore()": FunctionFragment;
    "projects()": FunctionFragment;
    "setPayerPreferences(address,bool)": FunctionFragment;
    "setTerminal(uint256,address)": FunctionFragment;
    "terminalOf(uint256)": FunctionFragment;
    "unstakedTicketsPreferenceOf(address)": FunctionFragment;
  };

  getFunction(
    nameOrSignatureOrTopic:
      | "addressesOf"
      | "beneficiaryOf"
      | "deployAddress"
      | "operatorStore"
      | "projects"
      | "setPayerPreferences"
      | "setTerminal"
      | "terminalOf"
      | "unstakedTicketsPreferenceOf"
  ): FunctionFragment;

  encodeFunctionData(
    functionFragment: "addressesOf",
    values: [PromiseOrValue<BigNumberish>]
  ): string;
  encodeFunctionData(
    functionFragment: "beneficiaryOf",
    values: [PromiseOrValue<string>]
  ): string;
  encodeFunctionData(
    functionFragment: "deployAddress",
    values: [PromiseOrValue<BigNumberish>, PromiseOrValue<string>]
  ): string;
  encodeFunctionData(
    functionFragment: "operatorStore",
    values?: undefined
  ): string;
  encodeFunctionData(functionFragment: "projects", values?: undefined): string;
  encodeFunctionData(
    functionFragment: "setPayerPreferences",
    values: [PromiseOrValue<string>, PromiseOrValue<boolean>]
  ): string;
  encodeFunctionData(
    functionFragment: "setTerminal",
    values: [PromiseOrValue<BigNumberish>, PromiseOrValue<string>]
  ): string;
  encodeFunctionData(
    functionFragment: "terminalOf",
    values: [PromiseOrValue<BigNumberish>]
  ): string;
  encodeFunctionData(
    functionFragment: "unstakedTicketsPreferenceOf",
    values: [PromiseOrValue<string>]
  ): string;

  decodeFunctionResult(
    functionFragment: "addressesOf",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "beneficiaryOf",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "deployAddress",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "operatorStore",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "projects", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "setPayerPreferences",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "setTerminal",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "terminalOf", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "unstakedTicketsPreferenceOf",
    data: BytesLike
  ): Result;

  events: {
    "DeployAddress(uint256,string,address)": EventFragment;
    "SetPayerPreferences(address,address,bool)": EventFragment;
    "SetTerminal(uint256,address,address)": EventFragment;
  };

  getEvent(nameOrSignatureOrTopic: "DeployAddress"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "SetPayerPreferences"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "SetTerminal"): EventFragment;
}

export interface DeployAddressEventObject {
  projectId: BigNumber;
  memo: string;
  caller: string;
}
export type DeployAddressEvent = TypedEvent<
  [BigNumber, string, string],
  DeployAddressEventObject
>;

export type DeployAddressEventFilter = TypedEventFilter<DeployAddressEvent>;

export interface SetPayerPreferencesEventObject {
  account: string;
  beneficiary: string;
  preferUnstakedTickets: boolean;
}
export type SetPayerPreferencesEvent = TypedEvent<
  [string, string, boolean],
  SetPayerPreferencesEventObject
>;

export type SetPayerPreferencesEventFilter =
  TypedEventFilter<SetPayerPreferencesEvent>;

export interface SetTerminalEventObject {
  projectId: BigNumber;
  terminal: string;
  caller: string;
}
export type SetTerminalEvent = TypedEvent<
  [BigNumber, string, string],
  SetTerminalEventObject
>;

export type SetTerminalEventFilter = TypedEventFilter<SetTerminalEvent>;

export interface TerminalDirectory extends BaseContract {
  connect(signerOrProvider: Signer | Provider | string): this;
  attach(addressOrName: string): this;
  deployed(): Promise<this>;

  interface: TerminalDirectoryInterface;

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
    addressesOf(
      _projectId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<[string[]]>;

    beneficiaryOf(
      arg0: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<[string]>;

    deployAddress(
      _projectId: PromiseOrValue<BigNumberish>,
      _memo: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    operatorStore(overrides?: CallOverrides): Promise<[string]>;

    projects(overrides?: CallOverrides): Promise<[string]>;

    setPayerPreferences(
      _beneficiary: PromiseOrValue<string>,
      _preferUnstakedTickets: PromiseOrValue<boolean>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    setTerminal(
      _projectId: PromiseOrValue<BigNumberish>,
      _terminal: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    terminalOf(
      arg0: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<[string]>;

    unstakedTicketsPreferenceOf(
      arg0: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<[boolean]>;
  };

  addressesOf(
    _projectId: PromiseOrValue<BigNumberish>,
    overrides?: CallOverrides
  ): Promise<string[]>;

  beneficiaryOf(
    arg0: PromiseOrValue<string>,
    overrides?: CallOverrides
  ): Promise<string>;

  deployAddress(
    _projectId: PromiseOrValue<BigNumberish>,
    _memo: PromiseOrValue<string>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  operatorStore(overrides?: CallOverrides): Promise<string>;

  projects(overrides?: CallOverrides): Promise<string>;

  setPayerPreferences(
    _beneficiary: PromiseOrValue<string>,
    _preferUnstakedTickets: PromiseOrValue<boolean>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  setTerminal(
    _projectId: PromiseOrValue<BigNumberish>,
    _terminal: PromiseOrValue<string>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  terminalOf(
    arg0: PromiseOrValue<BigNumberish>,
    overrides?: CallOverrides
  ): Promise<string>;

  unstakedTicketsPreferenceOf(
    arg0: PromiseOrValue<string>,
    overrides?: CallOverrides
  ): Promise<boolean>;

  callStatic: {
    addressesOf(
      _projectId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<string[]>;

    beneficiaryOf(
      arg0: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<string>;

    deployAddress(
      _projectId: PromiseOrValue<BigNumberish>,
      _memo: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<void>;

    operatorStore(overrides?: CallOverrides): Promise<string>;

    projects(overrides?: CallOverrides): Promise<string>;

    setPayerPreferences(
      _beneficiary: PromiseOrValue<string>,
      _preferUnstakedTickets: PromiseOrValue<boolean>,
      overrides?: CallOverrides
    ): Promise<void>;

    setTerminal(
      _projectId: PromiseOrValue<BigNumberish>,
      _terminal: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<void>;

    terminalOf(
      arg0: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<string>;

    unstakedTicketsPreferenceOf(
      arg0: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<boolean>;
  };

  filters: {
    "DeployAddress(uint256,string,address)"(
      projectId?: PromiseOrValue<BigNumberish> | null,
      memo?: null,
      caller?: PromiseOrValue<string> | null
    ): DeployAddressEventFilter;
    DeployAddress(
      projectId?: PromiseOrValue<BigNumberish> | null,
      memo?: null,
      caller?: PromiseOrValue<string> | null
    ): DeployAddressEventFilter;

    "SetPayerPreferences(address,address,bool)"(
      account?: PromiseOrValue<string> | null,
      beneficiary?: null,
      preferUnstakedTickets?: null
    ): SetPayerPreferencesEventFilter;
    SetPayerPreferences(
      account?: PromiseOrValue<string> | null,
      beneficiary?: null,
      preferUnstakedTickets?: null
    ): SetPayerPreferencesEventFilter;

    "SetTerminal(uint256,address,address)"(
      projectId?: PromiseOrValue<BigNumberish> | null,
      terminal?: PromiseOrValue<string> | null,
      caller?: null
    ): SetTerminalEventFilter;
    SetTerminal(
      projectId?: PromiseOrValue<BigNumberish> | null,
      terminal?: PromiseOrValue<string> | null,
      caller?: null
    ): SetTerminalEventFilter;
  };

  estimateGas: {
    addressesOf(
      _projectId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    beneficiaryOf(
      arg0: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    deployAddress(
      _projectId: PromiseOrValue<BigNumberish>,
      _memo: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    operatorStore(overrides?: CallOverrides): Promise<BigNumber>;

    projects(overrides?: CallOverrides): Promise<BigNumber>;

    setPayerPreferences(
      _beneficiary: PromiseOrValue<string>,
      _preferUnstakedTickets: PromiseOrValue<boolean>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    setTerminal(
      _projectId: PromiseOrValue<BigNumberish>,
      _terminal: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    terminalOf(
      arg0: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    unstakedTicketsPreferenceOf(
      arg0: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;
  };

  populateTransaction: {
    addressesOf(
      _projectId: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    beneficiaryOf(
      arg0: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    deployAddress(
      _projectId: PromiseOrValue<BigNumberish>,
      _memo: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    operatorStore(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    projects(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    setPayerPreferences(
      _beneficiary: PromiseOrValue<string>,
      _preferUnstakedTickets: PromiseOrValue<boolean>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    setTerminal(
      _projectId: PromiseOrValue<BigNumberish>,
      _terminal: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    terminalOf(
      arg0: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    unstakedTicketsPreferenceOf(
      arg0: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;
  };
}