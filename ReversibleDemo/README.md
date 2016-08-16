# ReversibleDemo

A non-working version of [ThisExternalAssembly](https://github.com/veox/solidity-dapps/blob/master/ThisExternalAssembly/ThisExternalAssembly.sol).

`solc` wraps everything but `send()` and `call()` in protective
`throw`s, which must be circumvented.

See [main article](https://wemakethings.net/2016/08/08/conditional_cancel/).
