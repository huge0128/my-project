pragma solidity >=0.7.0;

interface Attacker {
    function attack(uint speed) external returns (uint);
}

contract ASn is Attacker {
    function attack(uint speed) public pure returns (uint attackCnt) {
        return speed * speed;
    }
}