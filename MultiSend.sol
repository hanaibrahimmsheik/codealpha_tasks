// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Splits the Ether you send equally among a list of addresses
contract MultiSend {

    // Logs each payment (shows in the Remix terminal)
    event Sent(address indexed to, uint256 amount);

    // "payable" lets this function receive Ether
    function multiSend(address[] calldata recipients) public payable {
        uint256 count = recipients.length;
        require(count > 0, "No recipients");
        require(msg.value > 0, "Send some Ether");

        // Equal share for each address
        uint256 amountEach = msg.value / count;
        require(amountEach > 0, "Amount too small");

        // Send to each address, one by one
        for (uint256 i = 0; i < count; i++) {
            (bool success, ) = recipients[i].call{value: amountEach}("");
            require(success, "Transfer failed");
            emit Sent(recipients[i], amountEach);
        }

        // Return any leftover from rounding to the sender
        uint256 leftover = msg.value - (amountEach * count);
        if (leftover > 0) {
            (bool refunded, ) = msg.sender.call{value: leftover}("");
            require(refunded, "Refund failed");
        }
    }
}
