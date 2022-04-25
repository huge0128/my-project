var express = require('express');
var router = express.Router();

var Web3 = require('web3');
var web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:7777'));
console.log("web3.version: ", web3.version);

web3.eth.getAccounts().then(console.log);
console.log('-----------MarkReport Contract test-------------');

// var myContract = new web3.eth.Contract([abi], 'contract Address');

var myContract = new web3.eth.Contract([
	{
		"inputs": [],
		"name": "getMarkInfo",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getTxInfo",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "address",
				"name": "controller",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "address",
				"name": "reporter",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "string",
				"name": "swTrace",
				"type": "string"
			}
		],
		"name": "LogMarkInfo",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "address",
				"name": "controller",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "address",
				"name": "reporter",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "string",
				"name": "location",
				"type": "string"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "value",
				"type": "uint256"
			},
			{
				"indexed": false,
				"internalType": "string",
				"name": "_swTrace",
				"type": "string"
			}
		],
		"name": "LogReport",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "address",
				"name": "controller",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "address",
				"name": "reporter",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "value",
				"type": "uint256"
			}
		],
		"name": "LogTxInfo",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "address payable",
				"name": "_controller",
				"type": "address"
			},
			{
				"internalType": "string",
				"name": "_location",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_swTrace",
				"type": "string"
			}
		],
		"name": "report",
		"outputs": [],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getLocationList",
		"outputs": [
			{
				"internalType": "string[]",
				"name": "",
				"type": "string[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getReporterList",
		"outputs": [
			{
				"internalType": "address[]",
				"name": "",
				"type": "address[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
],'0xa492dE50291C30cd958A321Fa282FF90D22A4925');

myContract.methods.getLocationList().call({from:'0xfdf15D3Fd7705D44Ec071a9d6C5B002aab989D74'},function(err, result){
  console.log("LocationList: ", result);
  locationArr.push(result);
  console.log("LocationList: ", locationArr);
});

var locationArr = [];
//var reporterArr = [];

// --send method cost gas and send ether--
// myContract.methods.report('0xfdf15D3Fd7705D44Ec071a9d6C5B002aab989D74', '192.168.10.6','3->5').send({from: '0xf4c3982a5ebEE7dAB63791264A7fbFb372508F70', gas:3573388 , value: 1000000000000000000})
// .then(function(){
//     myContract.methods.getLocationList().call({from:'0xfdf15D3Fd7705D44Ec071a9d6C5B002aab989D74'},function(result){
//       console.log("LocationList: ", result);
//       locationArr.push(result);
//       //res.render('index', {location: locationArr});
//   });
// });


/* GET home page. */
router.get('/', function(req, res, next) {
// get the controller info
  web3.eth.getAccounts().then(function(accounts){
    var account = accounts[0];
    web3.eth.getBalance(account).then(function(balance){
      var amount = web3.utils.fromWei(balance, 'ether');
      res.render('index', { account: account, balance: amount, location: locationArr});
    });
  });
});
module.exports = router;
