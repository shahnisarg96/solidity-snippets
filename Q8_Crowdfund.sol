// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title Crowdfund Smart Contract
/// @author Nisarg Shah
/// @notice A basic crowdfunding contract that allows users to contribute funds toward a goal within a deadline
/// @dev Enables refunds if the goal is not met and secure withdrawal by the owner if successful
contract Crowdfund {
    /// @notice Address of the campaign creator
    address payable private owner;

    /// @notice Fundraising goal in wei
    uint256 public goal;

    /// @notice Deadline for the campaign as a UNIX timestamp
    uint256 public deadline;

    /// @notice Total amount of funds contributed so far
    uint256 public totalContributed;

    /// @notice Records contributions made by each address
    mapping(address => uint256) public contributions;

    /// @notice Emitted when a user contributes to the campaign
    /// @param contributor Address of the contributor
    /// @param amount Amount of ETH contributed
    event ContributionReceived(address indexed contributor, uint256 amount);

    /// @notice Emitted when the owner withdraws the funds
    /// @param amount Amount withdrawn
    event OwnerWithdraw(uint256 amount);

    /// @notice Emitted when a refund is issued to a contributor
    /// @param contributor Address receiving the refund
    /// @param amount Amount refunded
    event RefundIssued(address indexed contributor, uint256 amount);

    /// @notice Initializes the crowdfunding campaign
    /// @param _goal The fundraising goal in wei
    /// @param _durationSeconds Duration of the campaign in seconds
    constructor(uint256 _goal, uint256 _durationSeconds) {
        owner = payable(msg.sender);
        goal = _goal;
        deadline = block.timestamp + _durationSeconds;
    }

    /// @notice Allows users to contribute ETH to the campaign
    /// @dev Reverts if the campaign has already ended
    function contribute() external payable {
        require(block.timestamp <= deadline, "Campaign ended");
        contributions[msg.sender] += msg.value;
        totalContributed += msg.value;
        emit ContributionReceived(msg.sender, msg.value);
    }

    /// @notice Allows the owner to withdraw funds if the goal is met after the deadline
    /// @dev Reverts if called before deadline or if the goal hasn't been met
    function withdrawOwner() external {
        require(msg.sender == owner, "Not owner");
        require(block.timestamp > deadline, "Campaign not ended");
        require(totalContributed >= goal, "Goal not met");

        uint256 amount = address(this).balance;
        owner.transfer(amount);
        emit OwnerWithdraw(amount);
    }

    /// @notice Allows contributors to claim a refund if the goal was not met
    /// @dev Resets the contributor's balance to zero before transferring the refund
    function refund() external {
        require(block.timestamp > deadline, "Campaign not ended");
        require(totalContributed < goal, "Goal met");

        uint256 contributed = contributions[msg.sender];
        require(contributed > 0, "No contributions");

        contributions[msg.sender] = 0;
        payable(msg.sender).transfer(contributed);
        emit RefundIssued(msg.sender, contributed);
    }

    /// @notice Returns the current balance held by the contract
    /// @return The balance in wei
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
