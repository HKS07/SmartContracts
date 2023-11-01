//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Banking{
    mapping( address => uint ) balance;
    address payable owner;

    struct

    constructor()  {
        owner = payable(msg.sender);
    }

    function deposite() public payable {
        require(msg.value > 0, "Deposit amount should be greater than 0.");
        // require(msg.sender == owner,"Owner not detected.");
        balance[msg.sender] += msg.value;
    }

    function withdraw(uint amount) public {
        // require(msg.sender == owner, "Owner can only withdraw the money");
        // require(amount <= balance[msg.sender], "Insufficient funds.");
        // require(amount > 0, "Amount should be greater than 0.");
        require(msg.sender == owner && amount <= balance[msg.sender] && amount > 0, " Invalid withdraw request ");
        payable(msg.sender).transfer(amount);
        balance[msg.sender] -= amount;
    }

    function transfer(address payable recipient, uint amount ) public {
        require(amount <= balance[msg.sender], "Insufficient funds.");
        require(amount > 0, "Amount should be greater than 0.");

        balance[msg.sender] -= amount;
        balance[recipient] += amount;
    }

    function getBalance(address payable user) public view returns (uint) {
        return balance[user];
    }

    function grantAccess(address payable user) public {
        require(msg.sender == owner, "only the owner can grant access.");
        owner = user;
    }

    function revokeAccess( address payable user ) public {
        require(msg.sender == owner," only owner can revoke access");
        require(user != owner,"cannot revoke access for the current owner");
        owner = payable(msg.sender);
    }

    function destroy() public {
        require(msg.sender == owner );
        selfdestruct(payable(owner));
    }
}