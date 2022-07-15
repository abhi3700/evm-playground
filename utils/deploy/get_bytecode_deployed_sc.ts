/* 
    Get bytecode of deployed SC from blockchain
    Here, the source code is not available.
*/
const Web3 = require("web3");
const provider = "YOUR_INFURA_OR_QUICKNODE_HTTP_ENDPOINT";
const web3 = new Web3(provider);
const UniswapV3Factory = "0x1F98431c8aD98523631AE4a59f267346ea31F984";
web3.eth.getCode(UniswapV3Factory).then(console.log);
