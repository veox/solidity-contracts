// run on testnet

contract TestExternalCallAssembly {
    uint public numcalls;
    uint public numcallsinternal;
    uint public numfails;
    uint public numsuccesses;
    
    address owner;

    event logCall(uint indexed _numcalls, uint indexed _numcallsinternal);
    
    modifier onlyOwner { if (msg.sender != owner) throw; _ }
    modifier onlyThis { if (msg.sender != address(this)) throw; _ }

    // constructor
    function TestExternalCallAssembly() {
        owner = msg.sender;
    }

    function failSend() external onlyThis returns (bool) {
        // storage change + nested external call
        numcallsinternal++;
        owner.send(42);

        // placeholder for state checks
        if (true) throw;

        // never happens in this case
        return true;
    }
    
    function doCall(uint _gas) onlyOwner {
        numcalls++;

        // https://ethereum.stackexchange.com/questions/6354/
        address addr = address(this);
        bytes4 sig = bytes4(sha3("failSend()"));

        bool ret;

        // try and work around `solc` safeguards against throws in calls
        assembly {
            let x := mload(0x40)
            mstore(x,sig)

            ret := call(
                _gas, // gas
                addr, // to addr
                0,    // value (none)
                x,    // Inputs are stored at location x
                0x4,  // input size - just the sig
                x,    // Store output over input (saves space)
                0x1)  // bool output (1 byte)

            //ret := mload(x) // no return value ever written :/
            mstore(0x40,add(x,0x4)) // Set storage pointer to empty space
        }

        if (ret) { numsuccesses++; }
        else { numfails++; }

        logCall(numcalls, numcallsinternal);
    }

    function selfDestruct() onlyOwner { selfdestruct(owner); }
    
    function() { throw; }
}
