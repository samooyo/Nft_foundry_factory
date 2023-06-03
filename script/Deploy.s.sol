// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Nft_factory.sol";

contract MyTokenScript is Script {
    function setUp() public {}

    function run() public {
        string memory seedPhrase = vm.readFile(".env");
        uint256 privateKey = vm.deriveKey(seedPhrase, 0);
        vm.startBroadcast(privateKey);
        MyToken myToken = new MyToken();

        vm.stopBroadcast();
    }
}
