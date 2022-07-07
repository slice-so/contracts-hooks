import { BigNumber } from "ethers"
import { ethers } from "hardhat"
import { Slicer } from "../../typechain-types/Slicer"
import { getEventArgsByIndex } from ".."
const { getContractAt } = ethers
import { BigNumberish } from "ethers"
import { productsModule } from "../../test/setup"

export const createProduct = async (
  slicerId: number,
  maxUnits_ = 0,
  units = 100,
  prices:
    | string
    | {
        currency: string
        dynamicPricing: boolean
        value: BigNumberish
      }[] = [
    {
      currency: ethers.constants.AddressZero,
      dynamicPricing: false,
      value: ethers.utils.parseEther("1.0"),
    },
  ],
  isFree_ = false,
  isInfinite_ = false,
  subSlicersProductsParam: {
    subSlicerId: number
    subProductId: number
  }[] = [],
  externalCallData: {
    externalAddress: string
    checkFunctionSignature: string
    execFunctionSignature: string
    data: any
    value: BigNumber
  } = {
    externalAddress: ethers.constants.AddressZero,
    checkFunctionSignature: "0x00000000",
    execFunctionSignature: "0x00000000",
    data: [],
    value: ethers.utils.parseEther("0"),
  },
  category = 0
) => {
  const productPrice =
    typeof prices == "string"
      ? [
          {
            currency: ethers.constants.AddressZero,
            dynamicPricing: false,
            value: ethers.utils.parseEther(prices),
          },
        ]
      : prices

  const txEvents = (
    await (
      await productsModule.addProduct(
        slicerId,
        {
          // categoryIndex: category,
          isFree: isFree_,
          maxUnitsPerBuyer: maxUnits_,
          isInfinite: isInfinite_,
          availableUnits: units,
          data: [],
          purchaseData: "0x1234",
          subSlicerProducts: subSlicersProductsParam,
          currencyPrices: productPrice,
        },
        externalCallData
      )
    ).wait()
  ).events
  const [
    ,
    productId,
    categoryIndex,
    isFree,
    maxUnits,
    isInfinite,
    availableUnits,
    creator,
    data,
    subSlicerProducts,
    currencyPrices,
    externalCall,
  ] = getEventArgsByIndex(
    txEvents,
    "ProductAdded",
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  )

  return {
    productId,
    categoryIndex,
    isFree,
    maxUnits,
    isInfinite,
    availableUnits,
    creator,
    data,
    subSlicerProducts,
    currencyPrices,
    externalCall,
    txEvents,
  }
}
