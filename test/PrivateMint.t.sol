// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Nft_factory.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

contract PrivateMintTest is Test, IERC721Receiver {
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

    function testFail_WrongAddr() public {
        myToken.privateMint();
    }

    function testFail_NotActive() public {
        address[] memory addr = new address[](1);
        addr[0] = address(this);

        myToken.setPrivateMinters(addr);
        myToken.privateMint();
    }

    function test_Mint() public {
        address[] memory addr = new address[](1);
        addr[0] = address(this);

        myToken.setPrivateMinters(addr);
        myToken.setMints(false, true);
        myToken.privateMint{value: 0.001 ether}();
        assertEq(myToken.balanceOf(address(this)), 1);
    }

    function testFail_WrongValue() public {
        address[] memory addr = new address[](1);
        addr[0] = address(this);

        myToken.setPrivateMinters(addr);
        myToken.setMints(false, true);
        myToken.privateMint{value: 0.1 ether}();
    }
}
