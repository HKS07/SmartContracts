//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Automotive {
    //variables
    address public owner;
    mapping (address => bool) buyer;
    string public vehicleMake;
    string public vehicleModel;
    uint public price;

    //event
    event purchase(address buyer, string make, string model, uint price);

    //constructor
    constructor() {
        owner = msg.sender;
    }

    // function
    function buyVehicle(string memory _make, string memory _model) public payable {
        require(msg.value >= price);
        require(buyer[msg.sender] == false);
        vehicleMake = _make;
        vehicleModel = _model;
        buyer[msg.sender] = true; 
        emit purchase(msg.sender, _make, _model, price);
    }
    function setPrice(uint _price) public {
        require(msg.sender == owner);
        price = _price;
    }

    function checkOwnership() public view returns (bool) {
        return buyer[msg.sender];
    }

}

   