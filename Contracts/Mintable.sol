pragma solidity >0.7.0;

import "Contracts/ERC20.sol";

contract Mintable is ERC20 {
    using SafeMath for uint256;

    address private owner;

    mapping(address => bool) minters;

    constructor() public {
        owner = msg.sender; // contract deployer willbe the first Minter
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier onlyMinter() {
        require(minters[msg.sender]);
        _;
    }

    function addMinter(address addr) public onlyOwner returns (bool) { // Right Management
        minters[addr] = true;
        return true;
    }

    function mint(address to, uint256 tokens) public onlyMinter returns (bool) {
        // increase new mined token supply
        _totalSupply = _totalSupply.add(tokens);

        // transfer new token to somebody
        _balances[to] = _balances[to].add(tokens);
        emit Transfer(address(0), to, tokens);
        return true;
    }
}