// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title VotingSystem Smart Contract
/// @author Nisarg Shah
/// @notice A simple voting system where users can vote 'yes' or 'no' during an active voting session
/// @dev Includes admin-only control, vote tracking, and basic result reporting
contract VotingSystem {
    // Admin address (assigned at deployment)
    address private admin;

    // Voting session status
    bool public votingActive;

    // Mapping to track whether an address has voted
    mapping(address => bool) private hasVoted;

    // Vote counts
    uint256 public yesCount;
    uint256 public noCount;

    /// @notice Emitted when a vote is cast
    /// @param voter Address of the voter
    /// @param vote True for yes, false for no
    event VoteCast(address indexed voter, bool vote);

    /// @notice Emitted when voting starts
    event VotingStarted();

    /// @notice Emitted when voting ends
    /// @param yesTotal Final count of yes votes
    /// @param noTotal Final count of no votes
    event VotingEnded(uint256 yesTotal, uint256 noTotal);

    /// @notice Constructor sets the contract deployer as the admin
    constructor() {
        admin = msg.sender;
    }

    /// @notice Modifier to restrict function access to the admin only
    modifier onlyAdmin() {
        require(msg.sender == admin, "Not admin");
        _;
    }

    /// @notice Starts a new voting session (admin only)
    /// @dev Resets yes and no counts; reverts if already active
    function startVoting() external onlyAdmin {
        require(!votingActive, "Already active");
        votingActive = true;
        delete yesCount;
        delete noCount;
        emit VotingStarted();
    }

    /// @notice Ends the current voting session (admin only)
    /// @dev Emits final vote tallies; reverts if not currently active
    function endVoting() external onlyAdmin {
        require(votingActive, "Not active");
        votingActive = false;
        emit VotingEnded(yesCount, noCount);
    }

    /// @notice Casts a vote during an active session
    /// @dev A user can vote only once; vote is either yes or no
    /// @param _yes True to vote yes, false to vote no
    function vote(bool _yes) external {
        require(votingActive, "Voting not active");
        require(!hasVoted[msg.sender], "Already voted");
        hasVoted[msg.sender] = true;

        if (_yes) {
            yesCount += 1;
        } else {
            noCount += 1;
        }

        emit VoteCast(msg.sender, _yes);
    }

    /// @notice Returns the results after voting has ended
    /// @dev Reverts if voting is still active
    /// @return yesTotal Number of yes votes
    /// @return noTotal Number of no votes
    function getResults() external view returns (uint256 yesTotal, uint256 noTotal) {
        require(!votingActive, "Voting still active");
        return (yesCount, noCount);
    }
}
