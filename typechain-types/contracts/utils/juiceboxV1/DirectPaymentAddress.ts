/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import type {
  BaseContract,
  BigNumber,
  BigNumberish,
  BytesLike,
  CallOverrides,
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

export interface DirectPaymentAddressInterface extends utils.Interface {
  functions: {
    "memo()": FunctionFragment;
    "projectId()": FunctionFragment;
    "terminalDirectory()": FunctionFragment;
  };

  getFunction(
    nameOrSignatureOrTopic: "memo" | "projectId" | "terminalDirectory"
  ): FunctionFragment;

  encodeFunctionData(functionFragment: "memo", values?: undefined): string;
  encodeFunctionData(functionFragment: "projectId", values?: undefined): string;
  encodeFunctionData(
    functionFragment: "terminalDirectory",
    values?: undefined
  ): string;

  decodeFunctionResult(functionFragment: "memo", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "projectId", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "terminalDirectory",
    data: BytesLike
  ): Result;

  events: {
    "Forward(address,uint256,address,uint256,string,bool)": EventFragment;
  };

  getEvent(nameOrSignatureOrTopic: "Forward"): EventFragment;
}

export interface ForwardEventObject {
  payer: string;
  projectId: BigNumber;
  beneficiary: string;
  value: BigNumber;
  memo: string;
  preferUnstakedTickets: boolean;
}
export type ForwardEvent = TypedEvent<
  [string, BigNumber, string, BigNumber, string, boolean],
  ForwardEventObject
>;

export type ForwardEventFilter = TypedEventFilter<ForwardEvent>;

export interface DirectPaymentAddress extends BaseContract {
  connect(signerOrProvider: Signer | Provider | string): this;
  attach(addressOrName: string): this;
  deployed(): Promise<this>;

  interface: DirectPaymentAddressInterface;

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
    memo(overrides?: CallOverrides): Promise<[string]>;

    projectId(overrides?: CallOverrides): Promise<[BigNumber]>;

    terminalDirectory(overrides?: CallOverrides): Promise<[string]>;
  };

  memo(overrides?: CallOverrides): Promise<string>;

  projectId(overrides?: CallOverrides): Promise<BigNumber>;

  terminalDirectory(overrides?: CallOverrides): Promise<string>;

  callStatic: {
    memo(overrides?: CallOverrides): Promise<string>;

    projectId(overrides?: CallOverrides): Promise<BigNumber>;

    terminalDirectory(overrides?: CallOverrides): Promise<string>;
  };

  filters: {
    "Forward(address,uint256,address,uint256,string,bool)"(
      payer?: PromiseOrValue<string> | null,
      projectId?: PromiseOrValue<BigNumberish> | null,
      beneficiary?: null,
      value?: null,
      memo?: null,
      preferUnstakedTickets?: null
    ): ForwardEventFilter;
    Forward(
      payer?: PromiseOrValue<string> | null,
      projectId?: PromiseOrValue<BigNumberish> | null,
      beneficiary?: null,
      value?: null,
      memo?: null,
      preferUnstakedTickets?: null
    ): ForwardEventFilter;
  };

  estimateGas: {
    memo(overrides?: CallOverrides): Promise<BigNumber>;

    projectId(overrides?: CallOverrides): Promise<BigNumber>;

    terminalDirectory(overrides?: CallOverrides): Promise<BigNumber>;
  };

  populateTransaction: {
    memo(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    projectId(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    terminalDirectory(overrides?: CallOverrides): Promise<PopulatedTransaction>;
  };
}