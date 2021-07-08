// SPDX-License-Identifier: MIT


/*

    About
    =====
    1. Simple example: with a pure function
    2. Advanced example: with a struct
    3. using...for
    4. Deployed vs Embedded libraries
        - Deployed: library is deployed at separate address. And multiple contracts can call library functions.
        - Embedded: library is present inside the contract itself
    
    Testing
    =======

    Reference
    =========
    https://www.youtube.com/watch?v=25MLAnIzXRw

*/

pragma solidity ^0.8.6;

library MyLibrary {
    struct Player {
        uint score;
    }


    function add10(uint _a) external pure returns(uint){
        return _a + 10;
    }

    function incrementScore(Player storage _player, uint points) external {
        _player.score += points;
    }
}

contract MyContract {
    using MyLibrary for MyLibrary.Player;   // M-2
    mapping(uint => MyLibrary.Player) players;

    function foo() external {
        // uint result = MyLibrary.add10(10);       // 1.
        // MyLibrary.incrementScore(players[0], 10);   // M-1
        players[0].incrementScore(10);              // M-2
    }

}
