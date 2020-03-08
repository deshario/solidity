pragma solidity ^0.6.0;

contract FunctionExample {
    mapping(address => uint64) public balanceReceived;

    address payable owner;

    constructor() public {
        owner = msg.sender;
    }

    function getOwner() public view returns(address){
        return owner;
    }

    function convertWeiToEther(uint _amountInWei) public pure returns(uint){
        return _amountInWei / 1 ether;
    }

    function destroySmartContract() public {
        require(msg.sender == owner,"You are not the owner");
        selfdestruct(owner);
    }

    function receiveMoney() public payable{
        assert(balanceReceived[msg.sender] + uint64(msg.value) >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += uint64(msg.value);
    }

    function withDrawlMoney(address payable to, uint64 amount) public{
        require(amount <= balanceReceived[msg.sender],"You dont have enough ether");
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - amount);
        balanceReceived[msg.sender] -= amount;
        to.transfer(amount);
    }

    // fallback() external payable {
    //     receiveMoney();
    // }

    // receive() external payable {
    // }
}