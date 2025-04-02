// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title Counter Smart Contract
/// @author Nisarg Shah
/// @notice This contract allows incrementing and retrieving a simple counter
/// @dev Demonstrates basic state variable manipulation in Solidity
contract Counter {
    // Private state variable to store the count
    uint256 private count;

    /// @notice Increments the counter by 1
    /// @dev Modifies the state variable `count`
    function increment() public {
        count += 1;
    }

    /// @notice Returns the current value of the counter
    /// @dev View function that does not modify the contract state
    /// @return The current count as a uint256
    function getCount() public view returns (uint256) {
        return count;
    }
}
