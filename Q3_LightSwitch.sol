// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title LightSwitch Smart Contract
/// @author Nisarg Shah
/// @notice This contract simulates a light switch that can be toggled on or off
/// @dev Demonstrates boolean state management in Solidity
contract LightSwitch {
    // Private state variable to represent the switch status: true = on, false = off
    bool private isOn = false;

    /// @notice Toggles the light switch between on and off states
    /// @dev Flips the boolean value of `isOn`
    function toggle() public {
        isOn = !isOn;
    }

    /// @notice Returns the current status of the light switch
    /// @dev View function that does not modify the contract state
    /// @return A boolean indicating if the switch is on (true) or off (false)
    function status() public view returns (bool) {
        return isOn;
    }
}
