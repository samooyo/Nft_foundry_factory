// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Nft_factory.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

contract PublicMintTest is Test, IERC721Receiver {
    // Needed to receive ERC721 tokens on a smart contract with safeTransfer
    function onERC721Received(
        address,
        address,
        uint256,
        bytes calldata
    ) external pure returns (bytes4) {
        return IERC721Receiver.onERC721Received.selector;
    }

    MyToken public myToken;

    function setUp() public {
        myToken = new MyToken();
    }
}
