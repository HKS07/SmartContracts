//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract automative{

    struct Vehicle
    {
        string vName;
        uint vPrice;
        string vType;
        bool haveIt;
        uint id;
    }
    address owner;
    uint counter;
    Vehicle[] public vehicles;
    // mapping (int => address) owner;


    constructor()
    {
        counter = 0;
        owner = msg.sender;
    }
    //events
    event vcl(string name, uint price, string vTp, bool haveIt, uint id);
    function createVehicle(string memory _vName, uint _vPrice, string memory _vType ) public {
        require(msg.sender == owner);
        vehicles.push(Vehicle(_vName,_vPrice,_vType,true,counter));
        emit vcl(_vName,_vPrice,_vType,true,counter);
        counter++;
        // owner

    }

    function showAllOwnedVehicle() public {
        require(msg.sender == owner);
        for( uint i = 0; i < vehicles.length; ++i )
        {
            if( vehicles[i].haveIt )
            {
                emit vcl( vehicles[i].vName, vehicles[i].vPrice, vehicles[i].vType, vehicles[i].haveIt, vehicles[i].id);
            }
        }
    }

}