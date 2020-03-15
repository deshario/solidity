pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/ownership/Ownable.sol";

contract SimpleWallet is Ownable {

    mapping(address => uint) public allowance;

    function addAllowance(address _who, uint _amount) public onlyOwner{
        allowance[_who] = _amount;
    }

    modifier ownerOrAllowed(uint amount){
        require(isOwner() || allowance[msg.sender] >= amount,"You are not allowed");
        _;
    }

    function reduceAllowance(address _who, uint amount) internal {
        allowance[_who] -= amount;
    }
   
    function withDrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount) {
        require(_amount <= address(this.balance,"There are not enough funds in smart contract"));
        if(!isOwner()){
            reduceAllowance(msg.sender,_amount);
        }
        _to.transfer(_amount);
    }

    fallback () external payable {}
    
    receive() external payable {} 
}