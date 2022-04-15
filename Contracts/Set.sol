/**
* library只部署一次，但能被多个地方使用
* 没有状态变量
* 不能继承被继承
* 不能接受Ether
 */
 pragma solidity >=0.7.0;

 library Set {
    struct Data {
        mapping(int => bool) data;
    }
    function Insert(Data storage self, int key) public returns (bool) {
        if (self.data[key]) return false;
        self.data[key] = true;
        return true;
    }
    function Remove(Data storage self, int key) public returns (bool) {
        if (!self.data[key]) return false;
        self.data[key] = false;
        return true;
    }
    function Contain(Data storage self, int key) public returns (bool) {
        return self.data[key];
    }

 }

