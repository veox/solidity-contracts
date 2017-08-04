// manual deployment cheatsheet
// replace `demo` and `ThisExternalAssembly` with sed ;)

// https://github.com/ethereum/go-ethereum/wiki/Contract-Tutorial

// solc --gas ThisExternalAssembly.sol

// var owneraddr = "0x04b3faaa7c8127a80eb6d24672cfdaf4aecabbf8";
// var demo_src = '<paste code>'
// var demo_compiled = eth.compile.solidity(demo_src)
// var demo_contract = eth.contract(demo_compiled.ThisExternalAssembly.info.abiDefinition)

var demo = demo_contract.new([],
                             {from: owneraddr,
                              data: demo_compiled.ThisExternalAssembly.code,
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

// https://github.com/ethereum/go-ethereum/wiki/Contracts-and-Transactions#contract-info-metadata

// source = "contract test { function multiply(uint a) returns(uint d) { return a * 7; } }"
// // compile with solc
// contract = eth.compile.solidity(source).test
// // create contract object
// var MyContract = eth.contract(contract.info.abiDefinition)
// // extracts info from contract, save the json serialisation in the given file,
// contenthash = admin.saveInfo(contract.info, "~/dapps/shared/contracts/test/info.json")
// // send off the contract to the blockchain
// MyContract.new({from: primaryAccount, data: contract.code}, function(error, contract){
//     if(!error && contract.address) {
//         // calculates the content hash and registers it with the code hash in `HashReg`
//         // it uses address to send the transaction.
//         // returns the content hash that we use to register a url
//         admin.register(primaryAccount, contract.address, contenthash)
//         // here you deploy ~/dapps/shared/contracts/test/info.json to a url
//         admin.registerUrl(primaryAccount, hash, url)
//     }
// });


// https://ethereum.stackexchange.com/questions/3083/how-to-deploy-contract-into-local-running-node-using-solidity-browser/3097#3097

// var testContract = web3.eth.contract([]);
// var test = testContract.new(
//     {
//         from: web3.eth.accounts[0],
//         data: '6060604052600a8060106000396000f360606040526008565b00',
//         gas: 3000000
//     }, function(e, contract){
//         console.log(e, contract);
//         if (typeof contract.address != 'undefined') {
//             console.log('Contract mined! address: ' + contract.address + ' transactionHash: ' + contract.transactionHash);
//         }
//     })
