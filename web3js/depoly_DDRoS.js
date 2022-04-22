var Web3 = require('web3');
var web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:7777'));

web3.eth.getAccounts().then(console.log);

console.log('Server is deploying...');

var markreportContract = new web3.eth.Contract([{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"controller","type":"address"},{"indexed":false,"internalType":"address","name":"reporter","type":"address"},{"indexed":false,"internalType":"string","name":"swTrace","type":"string"}],"name":"LogMarkInfo","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"controller","type":"address"},{"indexed":false,"internalType":"address","name":"reporter","type":"address"},{"indexed":false,"internalType":"string","name":"location","type":"string"},{"indexed":false,"internalType":"uint256","name":"value","type":"uint256"},{"indexed":false,"internalType":"string","name":"_swTrace","type":"string"}],"name":"LogReport","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"controller","type":"address"},{"indexed":false,"internalType":"address","name":"reporter","type":"address"},{"indexed":false,"internalType":"uint256","name":"value","type":"uint256"}],"name":"LogTxInfo","type":"event"},{"inputs":[],"name":"getLocationList","outputs":[{"internalType":"string[]","name":"","type":"string[]"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getMarkInfo","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"getReporterList","outputs":[{"internalType":"address[]","name":"","type":"address[]"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getTxInfo","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address payable","name":"_controller","type":"address"},{"internalType":"string","name":"_location","type":"string"},{"internalType":"string","name":"_swTrace","type":"string"}],"name":"report","outputs":[],"stateMutability":"payable","type":"function"}]);

// data is compiled from bytecode
markreportContract.options.data = 'xxx'; 

var markreport = markreportContract.deploy({
}).send({
     from: '0xfdf15D3Fd7705D44Ec071a9d6C5B002aab989D74', // ethereum address to deploy the contract
     gas: '4700000'
   }, function (e, contract){
    console.log(e, contract);
    if (typeof contract.address !== 'undefined') {
         console.log('Contract mined! address: ' + contract.address + ' transactionHash: ' + contract.transactionHash);
    }
 }).then(function(contract){
    console.log("Server is working! , Contract address is: ", contract.options.address);
 }) 
