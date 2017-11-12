pragma solidity ^0.4.11;

contract Purchase {
    
    address public seller;
    
    event beforeAbort(address owner, address sender);
    
    event beforeInit(address inputOwner, address actualSender);
    
    struct  product {
        uint128 id;
        bytes23 discounted_price;
    }
    
   function Purchase (address _owner) {
       
       beforeInit(_owner, msg.sender);
        seller = msg.sender;
    }
    
    modifier onlySeller() {
        require(msg.sender == seller);
        _;
    }
    
    function abort() onlySeller {
        
        beforeAbort(seller, msg.sender);
        selfdestruct(seller);
    }
}

//when initiating the Purchase contract with some dummy address "0xfbb1b73c4f0bda4f67dca266ce6ef42f520fbb98",
//abort failed with error "Purchase.abort errored: VM error: revert. revert	The transaction has been reverted to the initial state"

//when initiating the contract with msg.sender, abort function executed successfully
