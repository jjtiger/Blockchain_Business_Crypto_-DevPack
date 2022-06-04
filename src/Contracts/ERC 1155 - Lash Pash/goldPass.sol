pragma solidity ^0.8.0;
import "./ERC1155.sol";


contract Pass is ERC1155 {
    uint id;
    //discount is calculated at PPM IE discount of 1000 means 0.1% off
    uint public constant total = 1000000;
    uint8 public constant GOLD = 0;
    uint8 public constant SILVER = 1;
    mapping(uint8 => uint) public costs;
    mapping(uint8 => uint) public _discounts;

    constructor(string memory uri) ERC1155 (uri){
        _mint(address(this), GOLD, 500, "");
        _mint(address(this), SILVER, 1000, "");
        costs[GOLD] = 10000 gwei;
        costs[SILVER] = 5000 gwei;
        _discounts[0] = 250000;
        _discounts[1] = 100000;
        
    
        
    }

    fallback() external payable {
        owner.transfer(msg.value);
    }

    function updateOwner(address newOwner) onlyOwner external {
        owner = newOwner;
    }

    function updateDiscounts(uint[] memory ids, uint[] memory discounts) onlyOwner external {
        require(ids.length < 2 && discounts.length == ids.length, "Array too large, lengths must match");
        for (uint i = 0; i < ids.length; i++) {
            _discounts[ids[i]] = discounts[i];
        }
    
    }

    function updateCost(uint8 _id, uint _cost) onlyOwner external {
        require (_cost > 0, "cost cannot be zero" );
        costs[_id] = _cost;
    }

    function buy(address recipient, uint8 _id) external payable {
        uint _cost = costs[_id];
        require(_cost > 0, "PASS DOES NOT HAVE COST ASSIGNED");
        require(msg.value > _cost, "attach payment");
        owner.transfer(msg.value);
        bytes memory data;
        
        _safeTransferFrom(address(this), recipient, _id, 1, data);
    }

    function approve() external {
        setApprovalForAll(address(this), true);
     }
}
