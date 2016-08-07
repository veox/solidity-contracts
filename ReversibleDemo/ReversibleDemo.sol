// `interface` would make a nice keyword ;)
contract TheDaoHardForkOracle {
    // `ran()` manually verified true on both ETH and ETC chains
    function forked() constant returns (bool);
}

// Demostrates calling own function in a "reversible" manner.
contract ReversibleDemo {
    // counters (all public to simplify inspection)
    uint public numcalls;
    uint public numcallsinternal;
    uint public numfails;
    uint public numsuccesses;

    address owner;

    // needed for "naive" and "oraclized" checks
    address constant withdrawdaoaddr = 0xbf4ed7b27f1d666546e30d74d50d173d20bca754;
    TheDaoHardForkOracle oracle = TheDaoHardForkOracle(0xe8e506306ddb78ee38c9b0d86c257bd97c2536b3);

    // meh, not using `indexed`
    event logCall(uint _numcalls, uint _numfails, uint _numsuccesses);

    modifier onlyOwner { if (msg.sender != owner) throw; _ }
    modifier onlyThis { if (msg.sender != address(this)) throw; _ }

    // constructor (needed to allow termination)
    function ReversibleDemo() {
        owner = msg.sender;
    }

    // external: increments stack height, even if invoked from same dapp
    // onlyThis: not allowed by other accounts (external or dapps)
    function sendIfNotForked() external onlyThis returns (bool) {
        numcallsinternal++;

        // naive check for "is this the classic chain"
        // guaranteed `true`: enough has been withdrawn already
        // three million ----------> 3'000'000
        if (withdrawdaoaddr.balance < 3000000 ether) {
            // intentionally not checking return value
            owner.send(42);
            // "reverse" if it's actually the HF chain
            if (oracle.forked()) throw;
        }

        // not exactly a "success": send() could have failed on classic
        return true;
    }

    function doCall() onlyOwner {
        numcalls++;

        // TODO: specify gas?..
        if (!this.sendIfNotForked()) {
            numfails++;
        }
        else {
            numsuccesses++;
        }
        logCall(numcalls, numfails, numsuccesses);
    }

    function selfDestruct() onlyOwner {
        selfdestruct(owner);
    }

    function() {
        // accept value trasfers, but don't do anything
    }
}
