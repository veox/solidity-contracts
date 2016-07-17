contract daoHardForkOracle {
    address constant WitdrawDAO = 0xbf4ed7b27f1d666546e30d74d50d173d20bca754;

    // public, so accessors available
    bool public ran;
    bool public forked;
    
    modifier after_dao_hf_block {
	if (block.number <= 1920000) throw;
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
	if (WithdrawDAO.balance >= 10*000*000 ether) forked = true;
    }
}
