// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

/// @custom:security-contact example@example.com
contract MyToken is ERC721, Pausable, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    uint256 public constant MAX_SUPPLY = 10_000;

    bool public publicMintActive = false;
    bool public privateMintActive = false;
    uint256 public publicMintPrice = 0.01 ether;
    uint256 public privateMintPrice = 0.001 ether;
    mapping(address => bool) privateMinters;

    constructor() ERC721("MyToken", "MTK") {}

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://xxx";
    }

    function setMints(
        bool _publicMintActive,
        bool _privateMintActive
    ) public onlyOwner {
        publicMintActive = _publicMintActive;
        privateMintActive = _privateMintActive;
    }

    function setPrivateMinters(
        address[] calldata _privateMinters
    ) public onlyOwner {
        for (uint i = 0; i < _privateMinters.length; i++) {
            privateMinters[_privateMinters[i]] = true;
        }
    }

    function privateMint() public payable {
        require(
            privateMinters[msg.sender],
            "!privateMint : you are not a private minter"
        );
        require(privateMintActive, "!privateMint : private mint is not active");
        require(
            msg.value == privateMintPrice,
            "!privateMint : value needs to be XXX ether"
        );
        _mint(msg.sender);
    }

    function publicMint() public payable {
        require(publicMintActive, "!publicMint : public mint is not active");
        require(
            msg.value == publicMintPrice,
            "!publicMint : value needs to be XXX ether"
        );
        _mint(msg.sender);
    }

    function _mint(address to) internal {
        uint256 tokenId = _tokenIdCounter.current();
        require(tokenId < MAX_SUPPLY, "!_mint : max supply reached");

        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }
}
