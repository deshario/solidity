pragma solidity ^0.6;

contract Ownable{
    address payable owner;

    constructor() public{
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(isOwner(),'You are not the owner');
        _;
    }

    function isOwner() public view returns(bool){
        return (msg.sender == owner);
    }
}

contract Item {
    uint public priceInWei;
    uint public index;
    uint public pricePaid;
    ItemManager parentContract;

    constructor(ItemManager _parentContract, uint _priceInWei, uint _index) public {
        priceInWei = _priceInWei;
        index = _index;
        parentContract = _parentContract;
    }

    receive() external payable{
        require(pricePaid == 0,'Item is paid already');
        require(priceInWei == msg.value,'Only full payments allowed');
        pricePaid += msg.value;
        (bool success, ) = address(parentContract).call.value(msg.value)(abi.encodeWithSignature('triggerPayment(uint256)', index));
        require(success,"The transaction wasn't successful, cancelling");
    }

    fallback() external{}
}

contract ItemManager is Ownable {

    enum supplyChainState{created, paid, delivered}

    event supplyChainStep(uint _itemIndex, uint _step, address _itemAddress);

    struct S_Item{
        Item item;
        string _identiier;
        uint _itemPrice;
        ItemManager.supplyChainState _state;
    }

    mapping(uint => S_Item) public items;
    uint itemIndex;

    function createItem(string memory identifier, uint itemPrice) public onlyOwner{
        Item item = new Item(this,itemPrice,itemIndex);
        items[itemIndex].item = item;
        items[itemIndex]._identiier = identifier;
        items[itemIndex]._itemPrice = itemPrice;
        items[itemIndex]._state = supplyChainState.created;
        emit supplyChainStep(itemIndex,uint(items[itemIndex]._state),address(item));
        itemIndex++;
    }

    function triggerPayment(uint _itemIndex) public payable{
        require(items[_itemIndex]._itemPrice == msg.value,'Only full payments accepted');
        require(items[_itemIndex]._state == supplyChainState.created,'Item is further in the chain');
        items[itemIndex]._state = supplyChainState.paid;
        emit supplyChainStep(itemIndex,uint(items[_itemIndex]._state),address(items[_itemIndex].item));
    }

    function triggerDelivery(uint _itemIndex) public onlyOwner{
        require(items[_itemIndex]._state == supplyChainState.paid,'Item is further in the chain');
        items[_itemIndex]._state = supplyChainState.delivered;
        emit supplyChainStep(_itemIndex,uint(items[_itemIndex]._state),address(items[_itemIndex].item));
    }
}