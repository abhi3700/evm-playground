interface IFoo {
    function foo(string, uint256) external payable;
}

IFoo(addr).foo{value: msg.value, gas: 5000}("call foo", 123)