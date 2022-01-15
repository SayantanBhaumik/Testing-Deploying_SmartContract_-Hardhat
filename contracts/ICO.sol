//SPDX-License-Identifier : MIT 
pragma solidity ^0.8.0;

import './HumilityCoin.sol';

contract HumilityCoinICO {

    address internal admin;
    HumilityCoin public coinContract;
    uint256 public coinPrice;
    uint256 public coinSold;

    event ICO (address _buyer , uint256 _value);

    function CoinICO(HumilityCoin _coinContract ,uint256 _coinPrice) public{
        admin=msg.sender;
        coinContract= _coinContract;
        coinPrice= _coinPrice;
    }
    
    //pure is subset of constant
    //restrictive
    //doesnt change or read blockchain state
    function product (uint x, uint y) internal pure returns(uint z){
        
        //??
        require(y==0 || (z=x*y)/y==x);
    }

    modifier AmountPayable (uint256 _noOfcoins, uint256 coinprice) {
        require(msg.value == product(_noOfcoins,coinPrice));
        _;
    }

    function buyCoins(uint _noOfcoins) public payable AmountPayable(_noOfcoins,coinPrice) {
        
        //this belongs to smart contract
        //this ??
        require(coinContract.balanceOf(this) >= _noOfcoins);
        require (coinContract.transfer(msg.sender,_noOfcoins));
        coinSold = coinSold + _noOfcoins;
        emit ICO (msg.sender,_noOfcoins);
    }

    function endSale()public {

        //admin decides the end of ICO
        require(msg.sender==admin);

        // collect the Ethers that were raised during ICO
        require(coinContract.transfer(admin,coinContract.balanceOf(this)));

    }


    



}
