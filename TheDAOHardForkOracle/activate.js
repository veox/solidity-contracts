// geth filter callback to send activating transaction

// enable filter with this (in geth console), on both nodes:
// loadScript("/path/to/activate.js");
// var forkfilter = web3.eth.filter('latest');
// forkfilter.watch(forkfilter_callback);

var forkfilter_callback = function(e,r) {
    var forkblock = 1920000;
    var senderaddr = eth.accounts[4];
    var oracleaddr = "0xe8e506306ddb78ee38c9b0d86c257bd97c2536b3";
    var oracleabi = [
	{
	    "constant":true,
	    "inputs":[],
	    "name":"ran",
	    "outputs":[{"name":"","type":"bool"}],
	    "type":"function"
	},
	{
	    "constant":true,
	    "inputs":[],
	    "name":"forked",
	    "outputs":[{"name":"","type":"bool"}],
	    "type":"function"
	},
	{
	    "constant":true,
	    "inputs":[],
	    "name":"notforked",
	    "outputs":[{"name":"","type":"bool"}],
	    "type":"function"
	};
    ];

    var oracle = eth.contract(oracleabi).at(oracleaddr);

    if (eth.blockNumber == forkblock) {	
	console.log("========= BRACE FOR IMPACT =========");
	eth.sendTransaction({from: sender, to: oracleaddr, value: "0"});
    }

    if (eth.blockNumber == forkblock+1) {
	var ran = oracle.ran();
	var forked = oracle.forked();

	if (!ran) {
	    
	}
	else {
	    
	}
    }
});
