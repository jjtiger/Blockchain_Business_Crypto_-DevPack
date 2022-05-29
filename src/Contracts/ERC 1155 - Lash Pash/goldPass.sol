pragma solidity ^0.8.0;
import "./ERC1155.sol";


contract Pass is ERC1155 {
    uint id;
    //discount is calculated at PPM IE discount of 1000 means 1% off
    uint public constant total = 1000000;
    uint public constant GOLD = 0;
    uint public constant SILVER = 1;

    
    


    constructor(string memory uri) ERC1155 (uri){
        _mint(msg.sender, GOLD, 500, "");
        _mint(msg.sender, SILVER, 1000, "");
        
        
    }

    fallback() external payable {
        owner.transfer(msg.value);
    }

    function updateDiscounts(uint[] memory ids, uint[] memory discounts) onlyOwner external {
        require(ids.length < 2 && discounts.length == ids.length, "Array too large, lengths must match");
        for (uint i = 0; i < ids.length; i++) {
            discounts[ids[i]] = discounts[i];
        }
    
    }

    function sell(address recipient, uint ids) onlyOwner external payable {
        require(msg.value > 0, "attach payment");
        owner.transfer(msg.value);
        bytes memory data;

        safeTransferFrom(owner, recipient, ids, 1, data);

    }
}
