// `interface` would make a nice keyword ;)
contract TheDaoHardForkOracle {
    // bool ran(); // manually verified true on both ETH and ETC
    bool forked();
}

// Demostrates calling own function in a "reversible" manner.
contract ReversibleDemo {
    // all public to simplify inspection
    uint public numcalls;
    uint public numcallsinternal;
    uint public numfails;
    uint public numsuccesses;

    address owner;

    event logCallFailed() {/* TODO */}
    event logCallSucceeded() {/* TODO */}

    modifier onlyOwner { if (msg.sender != owner) throw; _ }
    modifier onlyThis { if (msg.sender != this) throw; _ }

    // constructor (needed to allow termination)
    function ReversibleDemo() {
        owner = msg.sender;
    }

    // external -> increments EVM stack, even if invoked from same dapp
    // onlyThis -> not allowed by other accounts (external or dapps)
    function sendIfNotForked() external onlyThis returns (bool) {
        numcallsinternal++;

        if (oracle.forked()) throw;

        return true;
    }

    function selfDestruct() onlyOwner {
        selfdestruct(owner);
    }

    fuction() {
        // accept value trasfers, but don't do anything
        if (msg.value != 0) return;

        numcalls++;

        // TODO: limit gas?
        bool ret = this.sendIfNotForked();
        
        if (!ret) {
            numfails++;
            logCallFailed();
        }
        else {
            numsuccesses++;
            logCallSucceeded();
        }
    }
}
