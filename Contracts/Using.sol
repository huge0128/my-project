pragma solidity >=0.7.0;

import "Contracts/Set.sol"; // import

contract Mainv0 {
    Set.Data set;
    function insert(int key) public returns (bool) {
        return Set.Insert(set, key);
    }
    function remove(int key) public returns (bool) {
        return Set.Remove(set, key);
    }
    function contain(int key) public returns (bool) {
        return Set.Contain(set, key);
    }
 }

  contract Mainv1 {
    using Set for Set.Data;// 使用using for 

    Set.Data mySet;

    function insert(int key) public returns (bool) {
        return mySet.Insert(key);
    }
    function remove(int key) public returns (bool) {
        return mySet.Remove(key);
    }
    function contain(int key) public returns (bool) {
        return mySet.Contain(key);
    }
 }