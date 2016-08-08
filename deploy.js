// manual deployment cheatsheet
// replace `demo` and `ReversibleDemo` with sed ;)

// https://github.com/ethereum/go-ethereum/wiki/Contract-Tutorial

// solc --gas ReversibleDemo.sol

// var owneraddr = "0x04b3faaa7c8127a80eb6d24672cfdaf4aecabbf8";
// var demo_src = '<paste code>'
// var demo_compiled = eth.compile.solidity(demo_src)
// var demo_contract = eth.contract(demo_compiled.ReversibleDemo.info.abiDefinition)

var demo = demo_contract.new([],
                             {from: owneraddr,
                              data: demo_compiled.ReversibleDemo.code,
                              gas: 500000},
                             function(e, contract){
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
