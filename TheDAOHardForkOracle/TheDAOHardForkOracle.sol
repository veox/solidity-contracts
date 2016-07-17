contract TheDAOHardForkOracle {
    address constant WitdrawDAO = 0xbf4ed7b27f1d666546e30d74d50d173d20bca754;
    address constant DarkDAO = 0x304a554a310c7e546dfe434669c62820b7d83490;

    // public, so accessors available
    bool public ran;
    bool public forked;
    bool public notforked;
    
    modifier after_dao_hf_block {
	if (block.number < 1920000) throw;
	_
    }
    
    modifier run_once {
	if (ran) throw;
	_
    }

    // running is possible only once
    // after that the dapp can only throw
    function ()
	after_dao_hf_block run_once {
	ran = true;

	// 10M ether is ~ 2M less than would be available for a short
	// while in WithdrawDAO after the HF, but probably more than
	// anyone is willing to drop into WithdrawDAO in Classic
	// -- READABILITY -----> 10*000*000 <-- 10 million
	if (WithdrawDAO.balance >= 10000000 ether)
	    forked = true;

	// failsafe: if the above assumption is incorrect, HF tine
	// won't have balance in DarkDAO anyway, and Classic has a
	// sliver of time before DarkDAO split happens
	// -- READABILITY -> 3*000*000 <-------- 3 million
	if (DarkDAO.balance >= 3000000 ether)
	    notforked = true;

	// if both flags are true, then something went wrong
    }
}
