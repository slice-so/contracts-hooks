/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import {
  Signer,
  utils,
  Contract,
  ContractFactory,
  BigNumberish,
  Overrides,
} from "ethers";
import type { Provider, TransactionRequest } from "@ethersproject/providers";
import type { PromiseOrValue } from "../../../../common";
import type {
  TokenRepresentationProxy,
  TokenRepresentationProxyInterface,
} from "../../../../contracts/utils/juiceboxV1/TokenRepresentationProxy";

const _abi = [
  {
    inputs: [
      {
        internalType: "contract ITicketBooth",
        name: "_ticketBooth",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "_projectId",
        type: "uint256",
      },
      {
        internalType: "string",
        name: "name",
        type: "string",
      },
      {
        internalType: "string",
        name: "ticker",
        type: "string",
      },
    ],
    stateMutability: "nonpayable",
    type: "constructor",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "owner",
        type: "address",
      },
      {
        indexed: true,
        internalType: "address",
        name: "spender",
        type: "address",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "value",
        type: "uint256",
      },
    ],
    name: "Approval",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "from",
        type: "address",
      },
      {
        indexed: true,
        internalType: "address",
        name: "to",
        type: "address",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "value",
        type: "uint256",
      },
    ],
    name: "Transfer",
    type: "event",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "owner",
        type: "address",
      },
      {
        internalType: "address",
        name: "spender",
        type: "address",
      },
    ],
    name: "allowance",
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
        name: "spender",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "amount",
        type: "uint256",
      },
    ],
    name: "approve",
    outputs: [
      {
        internalType: "bool",
        name: "",
        type: "bool",
      },
    ],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "_account",
        type: "address",
      },
    ],
    name: "balanceOf",
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
    inputs: [],
    name: "decimals",
    outputs: [
      {
        internalType: "uint8",
        name: "",
        type: "uint8",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "spender",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "subtractedValue",
        type: "uint256",
      },
    ],
    name: "decreaseAllowance",
    outputs: [
      {
        internalType: "bool",
        name: "",
        type: "bool",
      },
    ],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "spender",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "addedValue",
        type: "uint256",
      },
    ],
    name: "increaseAllowance",
    outputs: [
      {
        internalType: "bool",
        name: "",
        type: "bool",
      },
    ],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "name",
    outputs: [
      {
        internalType: "string",
        name: "",
        type: "string",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "symbol",
    outputs: [
      {
        internalType: "string",
        name: "",
        type: "string",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "totalSupply",
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
        name: "to",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "amount",
        type: "uint256",
      },
    ],
    name: "transfer",
    outputs: [
      {
        internalType: "bool",
        name: "",
        type: "bool",
      },
    ],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "from",
        type: "address",
      },
      {
        internalType: "address",
        name: "to",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "amount",
        type: "uint256",
      },
    ],
    name: "transferFrom",
    outputs: [
      {
        internalType: "bool",
        name: "",
        type: "bool",
      },
    ],
    stateMutability: "nonpayable",
    type: "function",
  },
] as const;

const _bytecode =
  "0x60806040523480156200001157600080fd5b5060405162000c4c38038062000c4c833981016040819052620000349162000205565b8151829082906200004d90600390602085019062000092565b5080516200006390600490602084019062000092565b5050600580546001600160a01b0319166001600160a01b039690961695909517909455505060065550620002d5565b828054620000a09062000299565b90600052602060002090601f016020900481019282620000c457600085556200010f565b82601f10620000df57805160ff19168380011785556200010f565b828001600101855582156200010f579182015b828111156200010f578251825591602001919060010190620000f2565b506200011d92915062000121565b5090565b5b808211156200011d576000815560010162000122565b634e487b7160e01b600052604160045260246000fd5b600082601f8301126200016057600080fd5b81516001600160401b03808211156200017d576200017d62000138565b604051601f8301601f19908116603f01168101908282118183101715620001a857620001a862000138565b81604052838152602092508683858801011115620001c557600080fd5b600091505b83821015620001e95785820183015181830184015290820190620001ca565b83821115620001fb5760008385830101525b9695505050505050565b600080600080608085870312156200021c57600080fd5b84516001600160a01b03811681146200023457600080fd5b6020860151604087015191955093506001600160401b03808211156200025957600080fd5b62000267888389016200014e565b935060608701519150808211156200027e57600080fd5b506200028d878288016200014e565b91505092959194509250565b600181811c90821680620002ae57607f821691505b602082108103620002cf57634e487b7160e01b600052602260045260246000fd5b50919050565b61096780620002e56000396000f3fe608060405234801561001057600080fd5b50600436106100a95760003560e01c80633950935111610071578063395093511461012757806370a082311461013a57806395d89b411461014d578063a457c2d714610155578063a9059cbb14610168578063dd62ed3e1461017b57600080fd5b806306fdde03146100ae578063095ea7b3146100cc57806318160ddd146100ef57806323b872dd14610105578063313ce56714610118575b600080fd5b6100b661018e565b6040516100c3919061078c565b60405180910390f35b6100df6100da3660046107fd565b610220565b60405190151581526020016100c3565b6100f7610238565b6040519081526020016100c3565b6100df610113366004610827565b6102af565b604051601281526020016100c3565b6100df6101353660046107fd565b6102d3565b6100f7610148366004610863565b6102f5565b6100b6610382565b6100df6101633660046107fd565b610391565b6100df6101763660046107fd565b610411565b6100f7610189366004610885565b61041f565b60606003805461019d906108b8565b80601f01602080910402602001604051908101604052809291908181526020018280546101c9906108b8565b80156102165780601f106101eb57610100808354040283529160200191610216565b820191906000526020600020905b8154815290600101906020018083116101f957829003601f168201915b5050505050905090565b60003361022e81858561044a565b5060019392505050565b6005546006546040516375b0d9cd60e01b815260048101919091526000916001600160a01b0316906375b0d9cd90602401602060405180830381865afa158015610286573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906102aa91906108f2565b905090565b6000336102bd85828561056e565b6102c88585856105e8565b506001949350505050565b60003361022e8185856102e6838361041f565b6102f0919061090b565b61044a565b600554600654604051627eeac760e11b81526000926001600160a01b03169162fdd58e9161033b9186916004016001600160a01b03929092168252602082015260400190565b602060405180830381865afa158015610358573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061037c91906108f2565b92915050565b60606004805461019d906108b8565b6000338161039f828661041f565b9050838110156104045760405162461bcd60e51b815260206004820152602560248201527f45524332303a2064656372656173656420616c6c6f77616e63652062656c6f77604482015264207a65726f60d81b60648201526084015b60405180910390fd5b6102c8828686840361044a565b60003361022e8185856105e8565b6001600160a01b03918216600090815260016020908152604080832093909416825291909152205490565b6001600160a01b0383166104ac5760405162461bcd60e51b8152602060048201526024808201527f45524332303a20617070726f76652066726f6d20746865207a65726f206164646044820152637265737360e01b60648201526084016103fb565b6001600160a01b03821661050d5760405162461bcd60e51b815260206004820152602260248201527f45524332303a20617070726f766520746f20746865207a65726f206164647265604482015261737360f01b60648201526084016103fb565b6001600160a01b0383811660008181526001602090815260408083209487168084529482529182902085905590518481527f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925910160405180910390a3505050565b600061057a848461041f565b905060001981146105e257818110156105d55760405162461bcd60e51b815260206004820152601d60248201527f45524332303a20696e73756666696369656e7420616c6c6f77616e636500000060448201526064016103fb565b6105e2848484840361044a565b50505050565b6001600160a01b03831661064c5760405162461bcd60e51b815260206004820152602560248201527f45524332303a207472616e736665722066726f6d20746865207a65726f206164604482015264647265737360d81b60648201526084016103fb565b6001600160a01b0382166106ae5760405162461bcd60e51b815260206004820152602360248201527f45524332303a207472616e7366657220746f20746865207a65726f206164647260448201526265737360e81b60648201526084016103fb565b6001600160a01b038316600090815260208190526040902054818110156107265760405162461bcd60e51b815260206004820152602660248201527f45524332303a207472616e7366657220616d6f756e7420657863656564732062604482015265616c616e636560d01b60648201526084016103fb565b6001600160a01b03848116600081815260208181526040808320878703905593871680835291849020805487019055925185815290927fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef910160405180910390a36105e2565b600060208083528351808285015260005b818110156107b95785810183015185820160400152820161079d565b818111156107cb576000604083870101525b50601f01601f1916929092016040019392505050565b80356001600160a01b03811681146107f857600080fd5b919050565b6000806040838503121561081057600080fd5b610819836107e1565b946020939093013593505050565b60008060006060848603121561083c57600080fd5b610845846107e1565b9250610853602085016107e1565b9150604084013590509250925092565b60006020828403121561087557600080fd5b61087e826107e1565b9392505050565b6000806040838503121561089857600080fd5b6108a1836107e1565b91506108af602084016107e1565b90509250929050565b600181811c908216806108cc57607f821691505b6020821081036108ec57634e487b7160e01b600052602260045260246000fd5b50919050565b60006020828403121561090457600080fd5b5051919050565b6000821982111561092c57634e487b7160e01b600052601160045260246000fd5b50019056fea264697066735822122063232d066c70655fe54fefacdafb7e19520cc880f5069331ce0651a59464467164736f6c634300080d0033";

type TokenRepresentationProxyConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: TokenRepresentationProxyConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class TokenRepresentationProxy__factory extends ContractFactory {
  constructor(...args: TokenRepresentationProxyConstructorParams) {
    if (isSuperArgs(args)) {
      super(...args);
    } else {
      super(_abi, _bytecode, args[0]);
    }
  }

  override deploy(
    _ticketBooth: PromiseOrValue<string>,
    _projectId: PromiseOrValue<BigNumberish>,
    name: PromiseOrValue<string>,
    ticker: PromiseOrValue<string>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<TokenRepresentationProxy> {
    return super.deploy(
      _ticketBooth,
      _projectId,
      name,
      ticker,
      overrides || {}
    ) as Promise<TokenRepresentationProxy>;
  }
  override getDeployTransaction(
    _ticketBooth: PromiseOrValue<string>,
    _projectId: PromiseOrValue<BigNumberish>,
    name: PromiseOrValue<string>,
    ticker: PromiseOrValue<string>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): TransactionRequest {
    return super.getDeployTransaction(
      _ticketBooth,
      _projectId,
      name,
      ticker,
      overrides || {}
    );
  }
  override attach(address: string): TokenRepresentationProxy {
    return super.attach(address) as TokenRepresentationProxy;
  }
  override connect(signer: Signer): TokenRepresentationProxy__factory {
    return super.connect(signer) as TokenRepresentationProxy__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): TokenRepresentationProxyInterface {
    return new utils.Interface(_abi) as TokenRepresentationProxyInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): TokenRepresentationProxy {
    return new Contract(
      address,
      _abi,
      signerOrProvider
    ) as TokenRepresentationProxy;
  }
}