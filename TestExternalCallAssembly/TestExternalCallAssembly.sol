// run on testnet

contract TestExternalCallAssembly {
    uint public numcalls;
    uint public numcallsinternal;
    
    address owner;

    event logCall(uint indexed _numcalls, uint indexed _numcallsinternal);
    
    modifier onlyOwner { if (msg.sender != owner) throw; _ }
    modifier onlyThis { if (msg.sender != address(this)) throw; _ }

    // constructor
    function TestExternalCallAssembly() {
        owner = msg.sender;
    }

    function failSend() external onlyThis returns (bool) {
        numcallsinternal++;
        owner.send(42);

        // fake
        if (true) throw;

        return true;
    }
    
    function doCall(uint _gas) onlyOwner {
        numcalls++;

        // https://ethereum.stackexchange.com/questions/6354/
        address addr = address(this);
        bytes4 sig = bytes4(sha3("failSend()"));

        this.sendIfNotForked.gas(_gas)();

        logCall(numcalls, numcallsinternal);
    }

    function selfDestruct() onlyOwner { selfdestruct(owner); }
    
    function() { throw; }
}
