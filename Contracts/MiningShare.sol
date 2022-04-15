pragma solidity >=0.7.0;

import "Contracts/SafeMath.sol";

contract MiningShare {
    using SafeMath for uint;


    // 召集人 owner
    address private owner = address(0);
    // 召集人设置募资时间
    uint private closeBlock = 0;
    // 投资者：
    // 1.投资金额
    mapping(address => uint) private usersNTD;
    // 2.提领金额
    mapping(address => uint) private usersWithdrow;
    // 记录参数：
    // 1.总投资金额
    uint private totalNTD;
    // 2.总提领金额
    uint private totalWithdrow;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    modifier onlyShareHolders() {
        require(usersNTD[msg.sender] != 0);
        _;
    }
    modifier beforeCloseBlock() {
        require(block.number <= closeBlock);
        _;
    }
    modifier afterCloseBlock() {
        require(block.number > closeBlock);
        _;
    }

    // 召集人功能
    constructor() public {
        owner = msg.sender;
        closeBlock = block.number + 2000;
    }

    function CaptialIncrease(address account, uint NTD) public onlyOwner beforeCloseBlock {
        usersNTD[account] = usersNTD[account].add(NTD);
        totalNTD = totalNTD.add(NTD);
    }

    function CaptialDecrease(address account, uint NTD) public onlyOwner beforeCloseBlock {
        usersNTD[account] = usersNTD[account].sub(NTD);
        totalNTD = totalNTD.add(NTD);
    }

    function MyTotalNTD() public constant onlyShareHolders returns (uint) {
        return usersNTD[msg.sender];
    }

    function MyTotalWithdraw() public constant onlyShareHolders afterCloseBlock returns (uint) {
        return usersWithdraw[msg.sender];
    }

    function TotalMined() public constant onlyShareHolders afterCloseBlock returns (uint) {
        return totalWithdraw.add(address(this).balance);  
    }

    function Withdraw() public onlyShareHolders afterCloseBlock {
        uint totalMined = totalWithdraw.add(address(this).balance);
        // totalMined * hisNTD / totalNTD - userWithdraw;
        uint userCanWithdraw = totalMined.mul(
            usersNTD[msg.sender].div(totalNTD)).sub(
                usersWithdraw[msg.sender]);

        usersWithdraw[msg.sender].add(userCanwithdraw);
        totalWithdraw.add(userCanWithdraw);
        msg.sender.transfer(userCanWithdraw);
    }

}