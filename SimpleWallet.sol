pragma solidity ^0.6.0;

contract SimpleWallet{
    address public owner;

    constructor() public{
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(owner == msg.sender,"You are not allowded");
        _;
    }

    function withDrawlMoney(address payable _to, uint _amount) public onlyOwner {
        _to.transfer(_amount);
    }

    // function () external payable {

    // }
}