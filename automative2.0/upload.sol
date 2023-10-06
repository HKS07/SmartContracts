//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract automative{

    struct Vehicle{
        string make;
        string model;
        uint price;
        address owner;
    }
    uint counter = 0;
    Vehicle[] public vehicles;

    mapping(uint => address) vehicleOwner;

    //events
    event VehicleCreated(string make, string model, uint price, address owner);
    event VehicleTransferred(string make, string model, uint price, address prevOwner, address newOwner);
    event VehiclePriceUpdate(uint prevPrice, uint newPrice);

    //functions
    function createVehicle(string memory _make, string memory _model, uint _price) public {
        vehicles.push(Vehicle(_make,_model,_price,msg.sender));
        vehicleOwner[vehicles.length - 1] = msg.sender;
        emit VehicleCreated(_make, _model, _price, msg.sender);
    }

    function getVehicleDetails(uint _id) public view returns (string memory, string memory, uint, address) {
        require(_id < vehicles.length, "Invalid vehicle Id");
        return (vehicles[_id].make, vehicles[_id].model, vehicles[_id].price, vehicles[_id].owner );
    }

    function buyVehicle(uint _id) public payable {
        require(_id < vehicles.length,"Invalid vehicle Id");
        require(vehicleOwner[_id] != msg.sender, " Owner cannot buy owned vehicle");
        require(msg.value >= vehicles[_id].price, "Insufficient balance");

        address prevOwner = vehicleOwner[_id];
        vehicleOwner[_id] = msg.sender;
        vehicles[_id].owner = msg.sender;
        payable(prevOwner).transfer(msg.value);
        emit VehicleTransferred(vehicles[_id].make, vehicles[_id].model, vehicles[_id].price, prevOwner, vehicleOwner[_id]);
    }

    function updatePrice(uint _id, uint _price) public {
        require(_id < vehicles.length, "Invalid vehicle ID");
        require(msg.sender == vehicles[_id].owner);

        uint prePrice = vehicles[_id].price;
        vehicles[_id].price = _price;
        emit VehiclePriceUpdate(prePrice, vehicles[_id].price);
    }

    function checkOwnership(uint _id) public view returns (bool){
        require(_id < vehicles.length, "Invalid vehicle ID");
        return msg.sender == vehicleOwner[_id];
    }
 
}