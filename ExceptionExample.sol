pragma solidity ^0.6.0;

contract ExceptionExample {
    
    mapping(address => uint64) public balanceReceived;

    function receiveMoney() public payable{
        // balance after adding msg.value is still greater than balance before adding msg.value
        // if(balance + msg.value > balance){}
        assert(balanceReceived[msg.sender] + uint64(msg.value) >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += uint64(msg.value);
    }

    function withDrawMoney(address payable to, uint64 amount) public{
        require(amount <= balanceReceived[msg.sender],"You dont have enough ether");
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - amount);
        balanceReceived[msg.sender] -= amount;
        to.transfer(amount);
    }
}