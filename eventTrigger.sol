pragma solidity ^0.6.0;

contract ItemManager{

    enum SupplyChainState{Created, Paid, Delivered}

    struct S_Item{
        string identifier;
        uint itemPrice;
        ItemManager.SupplyChainState chainState;
    }

    mapping(uint => S_Item) public items;
    uint itemIndex;

    event SupplyChainStep(uint itemIndex, uint step);

    function createItem(string memory identifier, uint itemPrice) public {
        items[itemIndex].identifier = identifier;
        items[itemIndex].itemPrice = itemPrice;
        items[itemIndex].chainState = SupplyChainState.Created;
        emit SupplyChainStep(itemIndex,uint(items[itemIndex].chainState));
        itemIndex++;
    }

    function triggerPayment(uint _itemIndex) public payable {
        require(items[_itemIndex].itemPrice == msg.value, "Only Full payments accepted");
        require(items[_itemIndex].chainState == SupplyChainState.Created, "Item is further in the chain");
        items[_itemIndex].chainState = SupplyChainState.Paid;
        emit SupplyChainStep(_itemIndex,uint(items[_itemIndex].chainState));
    }

    function triggerDelivery(uint _itemIndex) public {
        require(items[_itemIndex].chainState == SupplyChainState.Paid,"Item is further in the chain");
        items[_itemIndex].chainState = SupplyChainState.Delivered;
        emit SupplyChainStep(_itemIndex,uint(items[_itemIndex].chainState));
    }
}