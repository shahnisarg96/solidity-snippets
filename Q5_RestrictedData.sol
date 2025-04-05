// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title RestrictedData Smart Contract
/// @author Nisarg Shah
/// @notice This contract stores a uint256 value that can only be modified by the owner
/// @dev Demonstrates constructor-based initialization, access control, and private state management
contract RestrictedData {
    // Address of the contract owner
    address private owner;

    // Private data variable that can be updated only by the owner
    uint256 private data;

    /// @notice Initializes the contract with the deployer as the owner and sets the initial data
    /// @param _initialData The initial value to store in the `data` variable
    constructor(uint256 _initialData) {
        owner = msg.sender;
        data = _initialData;
    }

    /// @notice Modifier to restrict access to owner-only functions
    /// @dev Reverts if the caller is not the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    /// @notice Allows the owner to update the stored data value
    /// @dev Restricted by the `onlyOwner` modifier
    /// @param _newData The new value to store
    function setData(uint256 _newData) external onlyOwner {
        data = _newData;
    }

    /// @notice Returns the currently stored data value
    /// @dev View function that does not modify state
    /// @return The stored uint256 data value
    function getData() public view returns (uint256) {
        return data;
    }
}
