// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title TimeLock
 * @notice Users can deposit Ether with a lock duration.
 *         Withdrawal is only allowed after the lock period ends.
 */
contract TimeLock {
    // Mapping: user address → deposited amount
    mapping(address => uint256) public deposits;

    // Mapping: user address → unlock timestamp
    mapping(address => uint256) public unlockTimes;

    // Events for transparency
    event Deposited(address indexed user, uint256 amount, uint256 unlockTime);
    event Withdrawn(address indexed user, uint256 amount);

    /**
     * @notice Deposit Ether and set a lock duration (in seconds)
     * @param lockDuration How many seconds the funds should stay locked
     */
    function deposit(uint256 lockDuration) external payable {
        require(msg.value > 0, "Must deposit some Ether");
        require(lockDuration > 0, "Lock duration must be greater than 0");

        // Add to existing deposit (or create new one)
        deposits[msg.sender] += msg.value;

        // Set / update unlock time
        unlockTimes[msg.sender] = block.timestamp + lockDuration;

        emit Deposited(msg.sender, msg.value, unlockTimes[msg.sender]);
    }

    /**
     * @notice Withdraw all locked Ether after the unlock time has passed
     */
    function withdraw() external {
        uint256 amount = deposits[msg.sender];
        require(amount > 0, "No funds to withdraw");
        require(block.timestamp >= unlockTimes[msg.sender], "Funds are still locked");

        // Effects first (Checks-Effects-Interactions pattern)
        deposits[msg.sender] = 0;
        unlockTimes[msg.sender] = 0;

        // Interaction
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Ether transfer failed");

        emit Withdrawn(msg.sender, amount);
    }

    // ========== View helpers ==========

    function getDeposit(address user) external view returns (uint256) {
        return deposits[user];
    }

    function getUnlockTime(address user) external view returns (uint256) {
        return unlockTimes[user];
    }

    function timeRemaining(address user) external view returns (uint256) {
        if (block.timestamp >= unlockTimes[user]) {
            return 0;
        }
        return unlockTimes[user] - block.timestamp;
    }
}
