// replace `oracle` and `TheDAOHardForkOracle` with sed ;)
// var oracle_src = '<paste code>'
// var oracle_compiled = eth.compile.solidity(oracle_src)
// var oracle_contract = eth.contract(oracle_compiled.TheDAOHardForkOracle.info.abiDefinition)

var oracle = oracle_contract.new([],{from:eth.accounts[0], data: oracle_compiled.TheDAOHardForkOracle.code, gas: 200000}, function(e, contract){
    if (!e) {
        if(!contract.address) {
            console.log("Contract transaction send: TransactionHash: " + contract.transactionHash + " waiting to be mined...");
        } else {
            console.log("Contract mined! Address: " + contract.address);
            console.log(contract);
        }
    } else {
        console.log("Error!");
        console.log(e);
    }
})
