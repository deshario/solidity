pragma solidity ^0.6.0;

contract MappingExample{

    mapping(address => uint) public balanceReceived;

    function getBalannce() public view returns(uint){
        return address(this).balance;
    }

    function sendMoney() public payable{
        balanceReceived[msg.sender] += msg.value;
    }

    function withDrawMoney(address payable to, uint amount) public {
        require(balanceReceived[msg.sender] >= amount,"Not enough balance");
        balanceReceived[msg.sender] -= amount;
        to.transfer(amount);
    }

    function withDrawAllMoney(address payable to) public{
        // to.transfer(address(this).balance);
        uint balanceToSend = balanceReceived[msg.sender];
        balanceReceived[msg.sender] = 0;
        to.transfer(balanceToSend);
    }
}



