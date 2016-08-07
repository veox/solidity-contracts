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

    event logCallFailed() {/* TODO */}
    event logCallSucceeded() {/* TODO */}
    
    modifier onlyThis {
        if (msg.sender != this) throw;
        _
    }

    // external -> increments EVM stack, even if invoked from same dapp
    // onlyThis -> not allowed by other accounts (external or dapps)
    function callMe() external onlyThis returns (bool) {
        numcallsinternal++;
        
        if (!oracle.ran()) throw;

        return true;
    }

    fuction() {
        numcalls++;

        // TODO: limit gas?
        bool ret = this.callMe();
        
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
