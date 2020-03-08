pragma solidity ^0.6.0;

contract MappingStructExample{

    struct Payment{
        uint amount;
        uint timestamps;
    }

    struct Balance{
        uint totalBalance;
        uint numPayments;
        mapping(uint => Payment) payments;
    }

    mapping(address => Balance) public balanceReceived;

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function sendMoney() public payable{
        balanceReceived[msg.sender].totalBalance += msg.value;
        Payment memory payment = Payment(msg.value,now);
        balanceReceived[msg.sender].payments[balanceReceived[msg.sender].numPayments] = payment;
        balanceReceived[msg.sender].numPayments++;
    }

    function withDrawMoney(address payable to, uint amount) public {
        require(balanceReceived[msg.sender].totalBalance >= amount,"Not enough balance");
        balanceReceived[msg.sender].totalBalance -= amount;
        to.transfer(amount);
    }

    function withDrawAllMoney(address payable to) public{
        // to.transfer(address(this).balance);
        uint balanceToSend = balanceReceived[msg.sender].totalBalance;
        balanceReceived[msg.sender].totalBalance = 0;
        to.transfer(balanceToSend);
    }
}