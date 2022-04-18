pragma solidity >=0.7.0;

// switch 
contract MarkReport {

    struct MarkInfo {
        address[] reporters; // ethereum address
        string[] locations; //  ip address 

        mapping(address => string) Markdata;  
        mapping(address => uint) MarkLedger;
    }

    mapping(address => MarkInfo) MarkHistory;

    event LogReport(address controller, address reporter,
     string location, uint value, string _swTrace);

    function report(address  payable _controller, string memory _location,
     string memory _swTrace) public payable {
        require(msg.value > 0); // 有成本的发送
        _controller.transfer(msg.value);

        if(MarkHistory[_controller].MarkLedger[msg.sender] == 0) {
            MarkHistory[_controller].reporters.push(msg.sender);
            MarkHistory[_controller].locations.push(_location);
        } 
        
        MarkHistory[_controller].MarkLedger[msg.sender] += msg.value;
        MarkHistory[_controller].Markdata[msg.sender] = _swTrace;
        emit LogReport(
            _controller, 
            msg.sender, 
            _location,
            msg.value,
            _swTrace);
    }
    // Sw Info
    function getReporterList() public view returns (address[] memory) {
        return MarkHistory[msg.sender].reporters;
    }
    // Location info
    function getLocationList() public view returns (string[] memory) {
        return MarkHistory[msg.sender].locations;
    }

    // transaction info
    event LogTxInfo(address controller, address reporter, uint value);
    function getTxInfo() public {
        for(uint i = 0; i < MarkHistory[msg.sender].reporters.length; i++) {
            address reporter = MarkHistory[msg.sender].reporters[i];
            emit LogTxInfo(msg.sender, reporter, MarkHistory[msg.sender].MarkLedger[reporter]);
        }
    }

    // mark Trace info
    event LogMarkInfo(address controller, address reporter, string swTrace);
    function getMarkInfo() public {
        for(uint i = 0; i < MarkHistory[msg.sender].reporters.length; i++) {
            address reporter = MarkHistory[msg.sender].reporters[i];
            emit LogMarkInfo(msg.sender, reporter, MarkHistory[msg.sender].Markdata[reporter]);
        }
    }

    

}

