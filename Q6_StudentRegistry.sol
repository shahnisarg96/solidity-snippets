// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title StudentRegistry Smart Contract
/// @author Nisarg Shah
/// @notice This contract allows storing and retrieving student records by ID
/// @dev Demonstrates the use of structs, mappings, events, and basic validation in Solidity
contract StudentRegistry {
    /// @notice Struct to hold student information
    struct Student {
        uint256 id;      // Unique student ID
        string name;     // Name of the student
        uint8 grade;     // Grade of the student (0-255)
    }

    // Mapping to store students by their unique ID
    mapping(uint256 => Student) private students;

    /// @notice Emitted when a new student is added to the registry
    /// @param id Unique ID of the student
    /// @param name Name of the student
    /// @param grade Grade of the student
    event StudentAdded(uint256 indexed id, string name, uint8 grade);

    /// @notice Adds a new student to the registry
    /// @dev Replaces any existing student with the same ID
    /// @param _id Unique ID of the student
    /// @param _name Name of the student (must not be empty)
    /// @param _grade Grade of the student
    function addStudent(uint256 _id, string calldata _name, uint8 _grade) external {
        require(bytes(_name).length > 0, "Name required");
        students[_id] = Student(_id, _name, _grade);
        emit StudentAdded(_id, _name, _grade);
    }

    /// @notice Retrieves a student's record by ID
    /// @dev Reverts if the student is not found (name is empty)
    /// @param _id Unique ID of the student
    /// @return The Student struct containing id, name, and grade
    function getStudent(uint256 _id) external view returns (Student memory) {
        require(bytes(students[_id].name).length > 0, "Student not found");
        return students[_id];
    }
}
