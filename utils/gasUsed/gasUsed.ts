import { ContractTransaction } from "ethers"

/**
 * @author Dom-Mac
 * @notice This file is not really a test, but a snippet of code that can be used to quickly estimate gas usage.
 * @dev Uncomment to use it
 */

export async function gasUsed(
  callback: Promise<ContractTransaction>,
  log = false
) {
  const gasUsed = (await (await callback).wait()).gasUsed
  log && console.log(Number(gasUsed), "\n")
  return Number(gasUsed)
}
