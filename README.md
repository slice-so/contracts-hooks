# Purchase Hooks - Contracts

This repo contains the purchase hooks to be implemented on the [Slice Interface](https://github.com/slice-so/contracts-hooks).

In the `contracts` folder you can find:

- Basic `SlicerPurchasable` contracts and other presets at [contracts/extensions/Purchasable](contracts/extensions/Purchasable)
- Hooks folder under [contracts/hooks](contracts/hooks)
- A template for quickly setting up a new hook at [contracts/template/MyHook](contracts/templates/MyHook), containing:
  - `{MyHook}.sol` Your purchase hook inheriting `SlicerPurchasableClone`
  - `{MyHookCloner}.sol`: Your purchase hook factory contract (cloner)
  - `deployments.json`: Deployment addresses of cloner contract for each chain ID

<!-- ## Add a new hook

Open a PR with your new hook. In order to be merged, it needs to satisfy the following requirements:

- Has tests
- ...
- Be deployed in at least one chain
- Be verified on etherscan -->

### Examples

- [ERC20Gated](/contracts/hooks/ERC20Gated/ERC20Gated.sol)
- [Allowlisted](/contracts/hooks/Allowlisted/Allowlisted.sol)
- [Cloner](/contracts/hooks/Allowlisted/AllowlistedCloner.sol)
