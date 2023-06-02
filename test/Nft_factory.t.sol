// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Nft_factory.sol";

contract MyTokenTest is Test {
    MyToken public myToken;

    function setUp() public {
        myToken = new MyToken();
    }

    function testName() public {
        assertEq(myToken.name(), "MyToken");
    }

    function testSymbol() public {
        assertEq(myToken.symbol(), "MTK");
    }

    function testInvariant() public {
        assertEq(myToken.MAX_SUPPLY(), 10_000);
        assertEq(myToken.publicMintPrice(), 0.01 ether);
        assertEq(myToken.privateMintPrice(), 0.001 ether);
    }
}
