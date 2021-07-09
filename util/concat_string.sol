string public hello;

function sayHello(string memory user ) public {
    hello = string(abi.encodePacked("Hello ", user));
}
