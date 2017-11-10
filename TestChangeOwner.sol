pragma solidity ^0.4.0;

contract OwnedToken {
    
    TokenCreator creator;
    address owner;
    bytes32 name;
    
    event beforeChangeName(
        address sender,
        address creator,
        bytes32 currentName,
        bytes32 newName
    );
    
    event afterTransfer(
        address sender,
        address creator,
        address curOwner,
        address newOwner
    );
    
    
    function OwnedToken(bytes32 _name) {
        
        owner = msg.sender;
        creator = TokenCreator(msg.sender);
        name = _name;
        
    }
    
    function changeName(bytes32 newName) {
        
        beforeChangeName(msg.sender, address(creator), name, newName);
        
        if(msg.sender == address(creator))
            name = newName;
    }
    
    function transfer(address newOwner) {
        
        if (msg.sender != owner) return;
        
        if (creator.isTokenTransferOK(owner, newOwner)) {
            
            owner = newOwner;
        }
        
        afterTransfer(msg.sender, owner, address(creator), address(newOwner));
        
    }
}

contract TokenCreator {
    
    function createToken(bytes32 name) 
        returns (OwnedToken tokenAddress)
    {
        return new OwnedToken(name);
    }
    
    function changeName(OwnedToken tokenAddress, bytes32 name) {
        tokenAddress.changeName(name);
    }
    
    function isTokenTransferOK(
        address currentOwner,
        address newOwner
    ) returns (bool ok) {
        address tokenAddress = msg.sender;
        
        return (keccak256(newOwner) & 0xff) == (bytes20(tokenAddress) & 0xff);
    }
}