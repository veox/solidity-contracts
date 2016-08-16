contract FallbackThrow {
    function () returns (bool) {
        throw;
    }
}
