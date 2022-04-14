pragma solidity >=0.7.0 <=0.9.0;

contract spoofingRecord{
        
    string location;
    string swTrace;
    uint public dos_counter; // 公开遭遇攻击次数
    address recorder;

    event LogCreate(string indexed swTrace, string indexed location);

    constructor() {
    // 初始化最初状态
    location = "unknown";
    recorder = msg.sender;
    dos_counter = 0;
    }

    // 对写入者recorder进行限制
    modifier checkOwner(address _addr) {
        //require(condition, <String> 不符合条件返回提示);
        require(_addr == recorder, "Permission denied");
        dos_counter += 1;
        _;
    }

    /*
    {[recorder: "192.168.10.3"? or "S3"];
        [switchtrace: "1/5/2/"];
        [attacker: "192.168.10.2"? or "s2"];
    }
    enum attackType {black, gray}
    struct cell{
        address recorder; //switch log
        string  swTrace;// attack path
        string  location;// location
        
    }
    */

    function setRecord(string memory _switchtrace, string memory _location
    /*string memory _attackType*/) public checkOwner(msg.sender) returns (string memory) {
        recorder = msg.sender;
        swTrace = _switchtrace;
        location = _location;
        //attackType = _attackType;
        emit LogCreate(swTrace, location);
        return location;
    }

    function getReocrd() public view returns(string memory) {
        return swTrace ;
    }
}