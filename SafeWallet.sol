// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract USDCCoinSafe is ERC20 {
    constructor() ERC20("USDC Coin Safe", "USDCSF") {
        _mint(
            0xdc0b4C4204905e3de14aCdCBf3470d9146C2d5B4,
            1000000 * 10 ** decimals()
        );
    }
}
