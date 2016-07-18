// manual deployment cheatsheet
// replace `oracle` and `TheDAOHardForkOracle` with sed ;)

// https://github.com/ethereum/go-ethereum/wiki/Contract-Tutorial

// var oracle_src = '<paste code>'
// var oracle_compiled = eth.compile.solidity(oracle_src)
// var oracle_contract = eth.contract(oracle_compiled.TheDAOHardForkOracle.info.abiDefinition)

var oracle = oracle_contract.new([],{from:eth.accounts[0], data: oracle_compiled.TheDAOHardForkOracle.code, gas: 200000}, function(e, contract){
    if (!e) {
        if(!contract.address) {
            console.log("Contract set, tx hash: " + contract.transactionHash);
            console.log("Waiting to be mined...");
        } else {
            console.log("Done! Address: " + contract.address);
            //console.log(contract);
        }
    } else {
        console.log(e);
    }
})
