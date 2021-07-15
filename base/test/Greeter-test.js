// We import Chai to use its asserting functions here.
const { expect } = require("chai");

// `describe` is a Mocha function that allows you to organize your tests. It's
// not actually needed, but having your tests organized makes debugging them
// easier. All Mocha functions are available in the global scope.

// `describe` receives the name of a section of your test suite, and a callback.
// The callback must define the tests of that section. This callback can't be
// an async function.
describe("Greeter contract", function () {
    // A common pattern is to declare some variables, and assign them in the
    // `before` and `beforeEach` callbacks.
    let Greeter;
    let hardhatGreeter;
    let owner;
    // let addr1;
    // let addr2;
    // let addrs;

    // `beforeEach` will run before each test, re-deploying the contract every
    // time. It receives a callback, which can be async.
    beforeEach(async function () {
        // Get the ContractFactory and Signers here.
        const Greeter = await ethers.getContractFactory("Greeter");
        const [owner] = await ethers.getSigners();      // also possible with one signer;
        // const [owner, addr1, addr2, ...addrs] = await ethers.getSigners();      // with multiple signers, useful during token transfers;

        // To deploy our contract, we just have to call Token.deploy() and await
        // for it to be deployed(), which happens onces its transaction has been
        // mined.
        hardhatGreeter = await Greeter.deploy("Hello, world!");

/*        // check the get function value == parsed value
        expect(await greeter.greet()).to.equal("Hello, world!");

        const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

        // wait until the transaction is mined
        await setGreetingTx.wait();

        expect(await greeter.greet()).to.equal("Hola, mundo!");
*/  
    });

    // You can nest describe calls to create subsections.
    describe("Deployment", function() {
        // `it` is another Mocha function. This is the one you use to define your
        // tests. It receives the test name, and a callback function.

        // If the callback function is async, Mocha will `await` it.
        it("should get the correct value", async function(){
            // Expect receives a value, and wraps it in an Assertion object. These
            // objects have a lot of utility methods to assert values.

            // This test expects the owner variable stored in the contract to be equal
            // to our Signer's owner.

            expect(await hardhatGreeter.greet()).to.equal("Hello, world!");
        });
    });


    describe("Transactions", function() {
        it("Should get the changed value", async function(){
            const setGreetingTx = await hardhatGreeter.setGreeting("Hola, mundo!");

            // wait until the transaction is mined
            await setGreetingTx.wait();

            expect(await hardhatGreeter.greet()).to.equal("Hola, mundo!");
        });
    });



});

