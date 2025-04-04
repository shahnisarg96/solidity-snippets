// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title SimpleWallet Smart Contract
/// @author Nisarg Shah
/// @notice A basic wallet contract that allows the owner to receive and withdraw ETH
/// @dev Demonstrates access control, Ether transfers, and contract balance management
contract SimpleWallet {
    // Address of the wallet owner (payable to allow ETH transfers)
    address payable private owner;

    /// @notice Sets the deployer as the wallet owner
    constructor() payable {
        owner = payable(msg.sender);
    }

    /// @notice Allows the contract to receive ETH directly
    /// @dev The receive function is triggered on plain ETH transfers with empty calldata
    receive() external payable {}

    /// @notice Modifier to restrict functions to the owner only
    /// @dev Reverts if the caller is not the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    /// @notice Allows the owner to withdraw a specified amount of ETH from the contract
    /// @dev Transfers ETH to the owner's address; reverts if funds are insufficient
    /// @param amount The amount of ETH (in wei) to withdraw
    function withdraw(uint256 amount) external onlyOwner {
        require(amount <= address(this).balance, "Insufficient funds");
        owner.transfer(amount);
    }

    /// @notice Returns the current balance of the contract in wei
    /// @dev View function that reads the contract's ETH balance
    /// @return The balance in wei
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
