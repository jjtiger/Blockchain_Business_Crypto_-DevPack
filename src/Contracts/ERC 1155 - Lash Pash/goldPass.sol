pragma solidity ^0.8.0;
import "./ERC1155.sol";


contract Pass is ERC1155 {
    address payable owner;
    uint id;
    //discount is calculated at PPM IE discount of 1000 means 1% off
    uint public constant total = 1000000
    uint public constant discount;

    modifier onlyOwner {
        require(msg.sender == owner);
    }
    constructor(uint _id, uint _discount, string memory uri) erc1155(_uri){
        owner = payable(msg.sender);
        id = id;
        discount = _discount
    }

    function mint(address recipient) external onlyOwner {
        //hardcoded 1 value for mint to prevent compounding discounts
        require(_balances[recipient] == 0, 'Recipient already holds token. NO COMPOUNDING');
        bytes memory data;
        _mint(recipient, id, 1, data);

    }
    
    function mintBatch(address[] memory recipients) external onlyOwner {
        //GAS INTENSIVE. 
        for (uint i = 0; i < recipients.length; i++) {
            mint(recipients[i])
        }
    }
}
