// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.9;

import "./Allowance.sol";

contract SimpleWallet is Allowance {
    
    event MoneySent (address indexed _beneficiary, uint _amount);
    event MoneyRecieved (address indexed _from, uint _amount);
    
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
    
    fallback () external payable {
       
    }
    
    receive () external payable {
        emit MoneyRecieved(msg.sender, msg.value);
    }
    
    function withdrawMoney (address payable _to, uint _amount) public ownerOrAllowed(_amount) {
        require(address(this).balance >= _amount, "Not enough money on smartcontract!");
        if(!isOwner()) {
            reduceAllowance(msg.sender, _amount);
        }
        emit MoneySent(_to, _amount);
        _to.transfer(_amount);
    }
    
}
