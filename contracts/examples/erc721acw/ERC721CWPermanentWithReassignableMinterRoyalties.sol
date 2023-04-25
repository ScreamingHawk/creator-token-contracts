// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "../../erc721c/presets/ERC721ACWPermanent.sol";
import "../../programmable-royalties/MinterRoyaltiesReassignableRightsNFT.sol";

contract ERC721ACWPermanentWithReassignableMinterRoyalties is ERC721ACWPermanent, MinterRoyaltiesReassignableRightsNFT {

    constructor(
        uint256 royaltyFeeNumerator_,
        address royaltyRightsNFTReference_,
        address wrappedCollectionAddress_,
        address transferValidator_, 
        string memory name_,
        string memory symbol_) 
        ERC721ACW(wrappedCollectionAddress_, transferValidator_, name_, symbol_) 
        MinterRoyaltiesReassignableRightsNFT(royaltyFeeNumerator_, royaltyRightsNFTReference_) {
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721AC, MinterRoyaltiesReassignableRightsNFT) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function _mint(address to, uint256 tokenId) internal virtual override {
        _onMinted(to, tokenId);
        super._mint(to, tokenId);
    }

    function _safeMint(address to, uint256 tokenId) internal virtual override {
        _onMinted(to, tokenId);
        super._safeMint(to, tokenId);
    }

    function _burn(uint256 tokenId) internal virtual override {
        super._burn(tokenId);
        _onBurned(tokenId);
    }
}
