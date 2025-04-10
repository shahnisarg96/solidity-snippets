// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title Animal Abstract Contract and Dog Implementation
/// @author Nisarg Shah
/// @notice Demonstrates inheritance and method overriding in Solidity
abstract contract Animal {
    /// @notice Returns a generic animal sound
    /// @return A string representing the animal sound
    function speak() public virtual returns (string memory) {
        return "Generic sound";
    }
}

/// @title Dog Contract
/// @notice Implements the Animal contract with a specific speak behavior
contract Dog is Animal {
    /// @notice Returns the dog's sound
    /// @return A string "Woof"
    function speak() public pure override returns (string memory) {
        return "Woof";
    }
}
