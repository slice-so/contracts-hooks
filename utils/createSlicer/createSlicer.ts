import { ethers } from "hardhat"
import { a0, a1, sliceCore } from "../../test/setup"
import { getEventArgsByIndex } from ".."
import { Slicer } from "../../typechain-types/Slicer"

export const createSlicer = async (
  payees = [
    { account: a0, shares: 90 },
    { account: a1, shares: 10 },
  ],
  minShares = 20,
  transferableTimelock = 0,
  releaseTimelock = 0,
  currencies: string[] = [],
  isImmutable = false,
  isControlled = false
) => {
  const newSlice = await sliceCore.slice(
    payees,
    minShares,
    currencies,
    releaseTimelock,
    transferableTimelock,
    isImmutable,
    isControlled
  )
  const tokenShares = payees.map((i) => i.shares)
  const tokensTotal = tokenShares.reduce((a, b) => a + b)
  const events = (await newSlice.wait()).events
  const [slicerAddress, tokenId] = getEventArgsByIndex(
    events,
    "TokenSliced",
    [0, 1]
  )
  const slicer = (await ethers.getContractAt("Slicer", slicerAddress)) as Slicer

  return {
    slicerAddress,
    tokenId: Number(tokenId),
    slicer,
    minShares,
    tokenShares,
    tokensTotal,
    isImmutable,
    isControlled,
  }
}
