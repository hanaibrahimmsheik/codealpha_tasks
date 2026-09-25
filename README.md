# CodeAlpha Blockchain Internship Tasks

## 1. CodeAlpha_SimpleStorage

A Solidity smart contract that stores an integer and lets you increase or decrease it by 1.

### Features
- `value`: public integer, readable from outside the contract
- `increment()`: increases value by 1
- `decrement()`: decreases value by 1

### How to run
1. Open remix.ethereum.org
2. Create `SimpleStorage.sol` and paste the code
3. Compile with Solidity 0.8.20 or higher
4. Deploy using the Remix VM environment
5. Click increment or decrement, then value, to check the result

---

## 2. CodeAlpha_MultiSend

A Solidity smart contract that splits Ether sent to it equally among a list of addresses.

### Features
- `multiSend(address[] recipients)`: payable function that divides the sent Ether equally among all addresses in the list
- Checks each transfer succeeds before continuing
- Refunds any leftover Ether (from rounding) back to the sender

### How to run
1. Open remix.ethereum.org
2. Create `MultiSend.sol` and paste the code
3. Compile with Solidity 0.8.20 or higher
4. Deploy using the Remix VM environment
5. Copy a few test account addresses, set Value to an amount of Ether, paste the addresses as a list into `multiSend`, then click Transact
6. Check the recipient accounts’ balances increased

---

## 3. CodeAlpha_TimeLock (Task 4 – Personal Portfolio / Crypto Locking)

A Solidity smart contract that allows users to deposit Ether with a time-lock. Funds can only be withdrawn after the lock period has expired.

### Features
- Users can deposit Ether along with a lock duration (in seconds)
- Deposit amount and unlock time are stored using mappings
- Uses `block.timestamp` to enforce the time-lock
- `withdraw()` function only allows withdrawal after the unlock time has passed
- Early withdrawals are blocked

### How to run
1. Open remix.ethereum.org
2. Create `TimeLock.sol` and paste the code
3. Compile with Solidity 0.8.20 or higher
4. Deploy using the Remix VM environment
5. Set Value to 1 Ether, call `deposit` with a lock duration (e.g. 60 or 300 seconds)
6. Try calling `withdraw` immediately → it should fail (early withdrawal blocked)
7. Wait until the lock time expires, then call `withdraw` again → it should succeed
