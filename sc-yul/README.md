# Yul

Learn by playing with Yul.

## Fundamentals

Yul is a low-level, intermediate language for the Ethereum Virtual Machine (EVM) that is especially useful for writing highly optimized smart contracts. Here are some of the most important commands and instructions in Yul, which you’ll encounter frequently while writing or optimizing Ethereum contracts.

### 1. **Basic Commands**

- **`let`**: Declares a variable that exists only within the block it’s declared in.

  ```yul
  let x := 5
  ```

- **`function`**: Declares a reusable block of code that can return values.

  ```yul
  function add(x, y) -> sum {
      sum := add(x, y)
  }
  ```

- **`if`**: Executes code only if a condition is met.

  ```yul
  if lt(x, 10) {
      // Code to execute if x is less than 10
  }
  ```

- **`for`**: A loop construct that allows for iteration.

  ```yul
  for { let i := 0 } lt(i, 10) { i := add(i, 1) } {
      // Code to execute in each loop iteration
  }
  ```

### 2. **Memory Management**

- **`mload`**: Loads a word (32 bytes) from memory at a specified location.

  ```yul
  let data := mload(0x40) // Loads data from memory position 0x40
  ```

- **`mstore`**: Stores a word (32 bytes) in memory at a specified location.

  ```yul
  mstore(0x40, 123) // Stores 123 at memory position 0x40
  ```

- **`mstore8`**: Stores a single byte in memory.

  ```yul
  mstore8(0x40, 0xff) // Stores the byte 0xff at memory position 0x40
  ```

- **`msize`**: Returns the current highest allocated memory address.

  ```yul
  let memSize := msize()
  ```

### 3. **Storage Management**

- **`sload`**: Loads data from storage at a specified key.

  ```yul
  let storedData := sload(0x0) // Loads data from storage slot 0
  ```

- **`sstore`**: Stores data in storage at a specified key.

  ```yul
  sstore(0x0, 123) // Stores 123 at storage slot 0
  ```

### 4. **Arithmetic Operations**

Arithmetic operations in Yul generally map directly to EVM opcodes. Some key arithmetic operations include:

- **`add`**: Addition

  ```yul
  let sum := add(5, 3)
  ```

- **`sub`**: Subtraction

  ```yul
  let difference := sub(5, 3)
  ```

- **`mul`**: Multiplication

  ```yul
  let product := mul(5, 3)
  ```

- **`div`**: Division (integer division)

  ```yul
  let quotient := div(5, 2)
  ```

- **`mod`**: Modulus

  ```yul
  let remainder := mod(5, 2)
  ```

### 5. **Comparison Operations**

- **`lt`**: Less than

  ```yul
  if lt(2, 5) {
      // Executes because 2 is less than 5
  }
  ```

- **`gt`**: Greater than

  ```yul
  if gt(5, 2) {
      // Executes because 5 is greater than 2
  }
  ```

- **`eq`**: Equal to

  ```yul
  if eq(5, 5) {
      // Executes because 5 is equal to 5
  }
  ```

- **`iszero`**: Checks if a value is zero.

  ```yul
  if iszero(x) {
      // Executes if x is zero
  }
  ```

### 6. **Logical Operations**

- **`and`**: Bitwise AND

  ```yul
  let result := and(0xff, 0x0f) // result = 0x0f
  ```

- **`or`**: Bitwise OR

  ```yul
  let result := or(0xf0, 0x0f) // result = 0xff
  ```

- **`xor`**: Bitwise XOR

  ```yul
  let result := xor(0xff, 0x0f) // result = 0xf0
  ```

- **`not`**: Bitwise NOT

  ```yul
  let result := not(0x0f) // result = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0
  ```

### 7. **Control Flow**

- **`switch`**: Like a conditional statement with multiple cases.

  ```yul
  switch x
  case 0 {
      // Executes if x is 0
  }
  case 1 {
      // Executes if x is 1
  }
  default {
      // Executes if x is neither 0 nor 1
  }
  ```

- **`break`**: Exits the current loop (in `for` statements).
- **`continue`**: Skips the current iteration and moves to the next one (in `for` statements).

### 8. **Calling External Contracts**

- **`call`**: Calls another contract.

  ```yul
  let success := call(gas(), address, value, inputOffset, inputSize, outputOffset, outputSize)
  ```

- **`delegatecall`**: Calls another contract with the same `msg.sender` and `msg.value`.

  ```yul
  let success := delegatecall(gas(), address, inputOffset, inputSize, outputOffset, outputSize)
  ```

- **`staticcall`**: Calls another contract in a static context, disallowing state changes.

  ```yul
  let success := staticcall(gas(), address, inputOffset, inputSize, outputOffset, outputSize)
  ```

- **`selfdestruct`**: Destroys the contract and sends all Ether to a specified address.

  ```yul
  selfdestruct(address)
  ```

### 9. **Return and Revert**

- **`return`**: Returns data from the function and halts execution.

  ```yul
  return(0, 32) // Returns 32 bytes starting at memory position 0
  ```

- **`revert`**: Reverts the transaction and returns error data.

  ```yul
  revert(0, 0) // Reverts with no data
  ```

### Example: A Simple Yul Contract

Here’s a simple Yul example that demonstrates some of the above commands:

```yul
object "SimpleStorage" {
    code {
        // Constructor code here
        sstore(0x0, 123) // Store initial value in storage slot 0
        return(0, 0)
    }

    object "runtime" {
        code {
            function getValue() -> value {
                value := sload(0x0)
            }

            function setValue(newValue) {
                sstore(0x0, newValue)
            }

            // Dispatch based on input data
            switch calldataload(0)
            case 0x00 {
                let result := getValue()
                mstore(0x0, result)
                return(0x0, 32)
            }
            case 0x01 {
                setValue(calldataload(4))
                return(0, 0)
            }
            default {
                revert(0, 0)
            }
        }
    }
}
```

This example demonstrates a basic contract that stores and retrieves a value using storage, handling two functions based on the input selector.

## Advanced

**Motivation**:

Writing a simple Yul `increment()` function saves a gas cost of 200 gas compared to its solidity counterpart.

```solidity
// in pure solidity
function increment() public {
    count += 1;
}

// in yul
function increment() public {
    assembly {
        sstore(count.slot, add(sload(count.slot), 1))
    }
}
```

```sh
# test run via `foundry`
$ forge test --match-test testIncrement

sol: 13051
yul: 12851
```

---

All operands are stored on a stack.

---

**Opcodes basics**:

In order to be useful, a stack-machine need to implement additional instructions, like `ADD`, `SUBSTRACT`, etc… Instructions usually pop one or more values from the stack, do some computation, and push the result. This order is called **Reverse Polish Notation**.

```
a + b      // Standard Notation (Infix)
a b add    // Reverse Polish Notation
```

---

**Understanding `ADD` operation with stack & memory**:

```solidity
assembly {
    let result := add(x, y)
    mstore(0x0, result)
    return(0x0, 32)
}
```

[Doc](../docs/add_comparo_yul.pdf)

![](../img/visual-stack-memory.png)

---

**Comparo of `SUB` operation**:

Consider this code with/without using `z` (external (to assembly scope) local variable). So, avoid using that. That would save additional `8 gas`.

The if code is [here](https://github.com/abhi3700/evm_playground/blob/main/sc-yul/src/Yul1.sol#L27)

The switch code is [here](https://github.com/abhi3700/evm_playground/blob/main/sc-yul/src/Yul1.sol#L43)

[Doc](../docs/sub_comparo_yul.pdf)

## Resources

- [Solidity Tutorial : all about Assembly](https://jeancvllr.medium.com/solidity-tutorial-all-about-assembly-5acdfefde05c)
