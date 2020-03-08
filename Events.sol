pragma solidity ^0.6.0;

contract EventExample {

    mapping(address => uint) public tokenBalance;

    event TokensSent(address from, address to, uint amount);

    constructor() public {
        tokenBalance[msg.sender] = 100;
    }

    function sendToken(address to, uint amount) public returns(bool){
        require(tokenBalance[msg.sender] >= amount,"Not enough tokens");
        assert(tokenBalance[to] + amount >= tokenBalance[to]);
        assert(tokenBalance[msg.sender] - amount <= tokenBalance[msg.sender]);
        tokenBalance[msg.sender] -= amount;
        tokenBalance[to] += amount;
        emit TokensSent(msg.sender,to,amount);
        return true;
    }
    
}