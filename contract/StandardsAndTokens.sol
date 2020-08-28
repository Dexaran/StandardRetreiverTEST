pragma solidity ^0.4.25;
 
 contract StandardizedToken {
     string public standard;
     mapping (address => uint256) public balances;
     
     function askStandard() public view returns (string)
     {
         return standard;
     }
     
     function balanceOf(address _who) public view returns (uint256)
     {
         return balances[_who];
     }
 }
 
 
 contract ERC20Token is StandardizedToken{
     constructor() public
     {
         balances[msg.sender] = 10000;
         standard = "ERC20";
     }
     
     function transfer(address _to, uint _amount) public
     {
         assert(balances[msg.sender] >= _amount);
         balances[msg.sender] -= _amount;
         balances[_to]        += _amount;
     }
 }
 
 
 contract ERC223Token is StandardizedToken{
     constructor() public
     {
         balances[msg.sender] = 10000;
         standard = "ERC223";
     }
     
     event LogData(bytes);
     
     function transfer(address _to, uint _amount, bytes memory _data) public
     {
         assert(balances[msg.sender] >= _amount);
         balances[msg.sender] -= _amount;
         balances[_to]        += _amount;
         
         emit LogData(_data);
     }
 }
 
 
 contract CustomToken is StandardizedToken{
     constructor() public
     {
         balances[msg.sender] = 10000;
         standard = "Custom";
     }
     
     function sendToken(address _to, uint _amount) public
     {
         uint256 _balance_before = balances[msg.sender];
         
         assert(balances[msg.sender] >= _amount);
         balances[msg.sender] -= _amount;
         balances[_to]        += _amount;
         
         if(_balance_before < balances[msg.sender])
         {
             revert();
         }
     }
 }
 
