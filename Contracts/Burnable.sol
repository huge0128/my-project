pragma solidity >0.7.0;

import "Contracts/ERC20.sol";

contract Burnable is ERC20 {
    using SafeMath for uint256;
    
    event Burn(address name, uint256 tokens);

    function burn(uint256 tokens) public returns (bool) {

        // _balance >= burn tokens
        require(tokens <= _balances[msg.sender]);
        // decrease mined token supply
        _totalSupply = _totalSupply.sub(tokens);
        // decrease balance
        _balances[msg.sender] = _balances[msg.sender].sub(tokens);

        emit Burn(msg.sender, tokens);
        emit Transfer(msg.sender, address(0), tokens);
        return true;
    }

    function burnFrom( ) public returns (bool) {
        
    }
}