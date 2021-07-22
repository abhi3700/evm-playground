// We import Chai to use its asserting functions here.
const { expect } = require("chai");

// `describe` is a Mocha function that allows you to organize your tests. It's
// not actually needed, but having your tests organized makes debugging them
// easier. All Mocha functions are available in the global scope.

// `describe` receives the name of a section of your test suite, and a callback.
// The callback must define the tests of that section. This callback can't be
// an async function.
describe("ERC20Token contract", function () {
    // A common pattern is to declare some variables, and assign them in the
    // `before` and `beforeEach` callbacks.
    let ERC20Token;
    let hardhatERC20Token;
    let owner;
    let addr1;
    let addr2;
    let addrs;

    // `beforeEach` will run before each test, re-deploying the contract every
    // time. It receives a callback, which can be async.
    beforeEach(async function () {
        // Get the ContractFactory and Signers here.
        ERC20Token = await ethers.getContractFactory("ERC20Token");
        // const [owner] = await ethers.getSigners();      // also possible with one signer;
        [owner, addr1, addr2, ...addrs] = await ethers.getSigners();      // with multiple signers, useful during token transfers;

        // To deploy our contract, we just have to call Token.deploy() and await
        // for it to be deployed(), which happens onces its transaction has been
        // mined.
        hardhatERC20Token = await ERC20Token.deploy();

        // console.log("Contract address: %s, owner: %s", hardhatERC20Token.address, owner.address);

    });

    // You can nest describe calls to create subsections.
    describe("Deployment", function() {
        it("should set the right token admin", async function(){
            expect(await hardhatERC20Token.admin()).to.equal(owner.address);
        });

        it("Should assign the total supply of tokens to the admin", async function(){
            const ownerBalance = await hardhatERC20Token.balanceOf(owner.address);
            expect(await hardhatERC20Token.totalSupply()).to.equal(ownerBalance);      // 10 B
        });
        it("should set the right allowance of owner, before approval", async function(){
            expect(await hardhatERC20Token.allowance(owner.address, owner.address)).to.equal(0);
        });

    });


    describe("Transactions", function() {
        it("should transfer between accounts", async function(){
            await hardhatERC20Token.transfer(addr1.address, 50);
            const addr1Balance = await hardhatERC20Token.balanceOf(addr1.address);

            expect(addr1Balance).to.equal(50);

            // -----------------------------------------------------------------------
            // transfer 50 tokens from addr1 to addr2
            await hardhatERC20Token.connect(addr1).transfer(addr2.address, 50);
            const addr2Balance = await hardhatERC20Token.balanceOf(addr2.address);            

            expect(addr2Balance).to.equal(50);

        });

        it("should fail when not having enough tokens", async function(){
            const initialOwnerBalance = await hardhatERC20Token.balanceOf(owner.address);

            // Try to send 1 token from addr1 (0 tokens) to owner.
            await expect(hardhatERC20Token.connect(addr1).transfer(owner.address, 1)).to.be.revertedWith("Not enough tokens");

            // Owner balance shouldn't have changed.
            expect(await hardhatERC20Token.balanceOf(owner.address)).to.equal(initialOwnerBalance);

        });
    });



});

