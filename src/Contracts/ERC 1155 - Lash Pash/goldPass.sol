pragma solidity ^0.8.0;
import "./ERC1155.sol";


contract Pass is ERC1155 {
    address payable owner;
    string id;
    constructor(string memory _id) {
        owner = payable(msg.sender);
        id = id;
    }

    function mint(address recipient, bytes memory data) public {
        _mint(recipient, id, 1, data);

    }
}
