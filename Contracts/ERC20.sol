pragma solidity >=0.7.0;

import "Contracts/IERC20.sol";
import "Contracts/SafeMath.sol";

contract ERC20 is IERC20 {
    using SafeMath for uint256;

    string public constant name = "huhu token";
    uint8 public constant decimals = 18;
    string public constant symbol = "HHT";

    // datastruct
    uint256  _totalSupply;
    mapping(address =>uint256) _balances;
    mapping(address =>mapping(address => uint256)) _approve;


    // 所有存在的Token数量
    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    // 读取 tokenOwner 这个address 所持有的Token数量
    function balanceof(address toeknOwner) external returns (uint256 balance) {
        return _balances[toeknOwner];
    }

    // 从msg.sender转tokens个Token给 to 这个address
    // msg.sender --- tokens--->to
    function transfer(address to, uint256 tokens) external returns (bool success) {

        return _transfer(msg.sender, to, tokens);
    }

    // 得到tokenOwner 授权给spender使用的Token剩余数量
    // tokenOwner -> spender -> tokens
    // address => address => uint256
    function allowance(address tokenOwner, address spender) external view returns (uint256 remaining) {
        return _approve[tokenOwner][spender];
    }

    // msg.sender 授权给spender可使用的自己的tokens个Token
    function approve(address spender, uint256 tokens) external returns (bool success){
        _approve[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }

    // 将tokens个Token从from转发到to
    function transferFrom(address from, address to, uint256 tokens) external returns (bool success){
        _approve[from][msg.sender] = _approve[from][msg.sender].sub(tokens);

        return _transfer(from, to, tokens);
    }

    function _transfer(address from, address to, uint256 tokens) internal returns (bool success) {
        /**_balances[msg.sender] -= tokens; // unsafe 
        _balances[to] += tokens;            // unsafe 
        */
        _balances[from] = _balances[from].sub(tokens);
        _balances[to] = _balances[to].add(tokens);
        emit Transfer(from, to, tokens);
        return true;
    }

}