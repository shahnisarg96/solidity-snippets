// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title HelloWorld Smart Contract
/// @author Nisarg Shah
/// @notice This contract stores and retrieves a simple greeting message
/// @dev This contract demonstrates a basic example of a read-only function in Solidity
contract HelloWorld {
    // Private variable to store the greeting message
    string private greeting = "Hello, Ethereum!";

    /// @notice Returns the stored greeting message
    /// @dev This is a view function, meaning it does not modify the state
    /// @return A string containing the greeting message
    function getGreeting() public view returns (string memory) {
        return greeting;
    }
}
