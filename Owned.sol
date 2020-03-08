pragma solidity ^0.6.0;

contract Owned{
    address owner;

    constructor() public {
        owner = msg.sender;
    }
    
    modifier onlyOwner(){
        require(msg.sender == owner, "You are not allowed");
        _; // function body
    }
}