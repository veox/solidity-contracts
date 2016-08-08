// manual deployment cheatsheet
// replace `demo` and `ReversibleDemo` with sed ;)

// https://github.com/ethereum/go-ethereum/wiki/Contract-Tutorial

// var demo_src = '<paste code>'
// var demo_compiled = eth.compile.solidity(demo_src)
// var demo_contract = eth.contract(demo_compiled.ReversibleDemo.info.abiDefinition)

var demo = demo_contract.new([],{from:eth.accounts[0], data: demo_compiled.ReversibleDemo.code, gas: 200000}, function(e, contract){
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
