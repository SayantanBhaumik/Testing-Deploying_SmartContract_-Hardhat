//SPDX-License-Identifier : MIT 

pragma solidity ^0.8.0 ;

contract HumilityCoin {
    //state variable for coin  name
    string public name= " Humility Coin";

    //state variable for coin symbol for cryptocurrency exchanges
    string public symbol = "!*! ";

    string public standard = " Humility Coin version 0 ";

    //state variable for total supply of coins in existence
    uint256 public totalSupply;

    //indexed parameters can be searched in transfer log datat structure
    event Transfer (address indexed _from , address indexed _to , uint256 _value);
    event Approval (address indexed _sender , address indexed _spender ,uint256 _value);

    //mapping to keep track of which  coin holder address has what balance
    mapping (address => uint256) public balanceOf; 

    // allowance mapping to see how much the coinholder is allowed to spend
    mapping (address=>mapping(address=>uint256)) public allowance;

    //computing total supply of that token
     function Coin(uint _initialSupply) public {
         
         //instance of balanceOf mapping
         balanceOf[msg.sender]= _initialSupply;
          totalSupply = _initialSupply ;
     }

     
     modifier validBalance (uint256 _value) {
         require(balanceOf[msg.sender] >=  _value);
         _;
     }

     //transfer function to allow holders to send coins to another account
     function transfer(address _to ,uint256 _value) public validBalance(_value) returns (bool success){

         //balance of sender gets deducted
         balanceOf[msg.sender] -= _value;

         //balance of reciever gets augmented
         balanceOf[_to] += _value;

         //emiting Transfer even to consumer
         emit Transfer(msg.sender, _to, _value);
         return true;
     }

    // approve function allows another coin holder to spend coins on a  exchange
     function approve (address _spender ,uint256 _value ) public returns (bool success){

         //instance of allowance mapping
         allowance [msg.sender][_spender] = _value;

         //Approval event emmitted
         emit Approval(msg.sender,_spender,_value);
         return true;
     }

     modifier stableBalance(uint256 _value, address _from){
         require (_value <= balanceOf[_from]);
         _;

     }

     modifier stableAllowance(uint _value , address _from){
         require (_value <= allowance [_from][msg.sender]);
         _;
     }

    // transferFrom that allows another account to transfer coins
    function  transferFrom(address _from ,address _to ,uint256 _value)public  stableBalance(_value,_from)  stableAllowance(_value,_from)
    returns(bool success){
        balanceOf[_from] -= _value ;
        balanceOf[_to] += _value;

        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from,_to,_value);
        return true;


    }







}
