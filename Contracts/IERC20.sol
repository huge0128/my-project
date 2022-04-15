//pragma solidity ^0.4.25;
pragma solidity >=0.7.0;

interface IERC20 {
    // 所有存在的Token数量
    function totalSupply() external view returns (uint256);

    // 读取 tokenOwner 这个address 所持有的Token数量
    function balanceof(address toeknOwner) external returns (uint256 balance);

    // 从msg.sender转tokens个Token给 to 这个address
    function transfer(address to, uint256 tokens) external returns (bool success);

    // 得到tokenOwner 授权给spender使用的Token剩余数量
    function allowance(address tokenOwner, address spender) external view returns (uint256 remaining);

    // msg.sender 授权给spender可使用的自己的tokens个Token
    function approve(address spender, uint256 tokens) external returns (bool success);

    // 将tokens个Token从from转发到to
    function transferFrom(address from, address to, uint256 tokens) external returns (bool success);

    event Transfer(address indexed from, address indexed to, uint256 tokens);

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 tokens
    );


}