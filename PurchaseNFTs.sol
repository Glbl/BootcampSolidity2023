// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

interface IUSDCCoin is IERC20 {
    function decimals() external view returns (uint8);
}

contract USDCCoin is ERC20 {
    constructor() ERC20("USDC Coin", "USDC") {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }
}

interface IMiPrimerNFT is IERC721 {
    function safeMint(address to, uint256 tokenId) external;
}

contract PurchaseNFTWithUSDC {
    // Activos digitales
    IMiPrimerNFT nftContract;
    IUSDCCoin usdcToken;

    // Billetera mancomunada
    address gnosisSafeAddress;

    // Precio de cada NFT;
    // 1 NFT = 25 USDC
    uint256 rate = 25 * 10 ** usdcToken.decimals();

    constructor(address _nftContractAddress, address _usdcContractAddress) {
        nftContract = IMiPrimerNFT(_nftContractAddress);
        usdcToken = IUSDCCoin(_usdcContractAddress);
    }

    function purchaseNftWithUsdc(uint256 _tokenId) public {
        usdcToken.transferFrom(msg.sender, gnosisSafeAddress, rate);
        nftContract.safeMint(msg.sender, _tokenId);
    }
}
