// `interface` would make a nice keyword ;)
contract TheDaoHardForkOracle {
    // `ran()` manually verified true on both ETH and ETC chains
    // function ran() constant returns (bool);
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

    address constant withdrawdaoaddr = 0xbf4ed7b27f1d666546e30d74d50d173d20bca754;
    TheDaoHardForkOracle oracle = TheDaoHardForkOracle(0xe8e506306ddb78ee38c9b0d86c257bd97c2536b3);

    // meh, not using `indexed`
    event logCallFailed(uint _numcalls, uint _numfails);
    event logCallSucceeded(uint _numcalls, uint _numsuccesses);

    modifier onlyOwner { if (msg.sender != owner) throw; _ }
    modifier onlyThis { if (msg.sender != this) throw; _ }

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
            owner.send(42 wei);
            // "reverse" if it's actually the HF chain
            if (oracle.forked()) throw;
        }

        return true;
    }

    function selfDestruct() onlyOwner {
        selfdestruct(owner);
    }

    function() {
        // accept value trasfers, but don't do anything
        if (msg.value != 0) return;

        numcalls++;

        // TODO: limit gas?
        bool ret = this.sendIfNotForked();
        
        if (!ret) {
            numfails++;
            logCallFailed(numcalls, numfails);
        }
        else {
            numsuccesses++;
            logCallSucceeded(numcalls, numsuccesses);
        }
    }
}
