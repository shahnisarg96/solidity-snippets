// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title Certificate Issuance Contract
/// @author Nisarg Shah
/// @notice This contract allows a university to issue and verify course certificates for students
/// @dev Each student is identified by a unique ID and associated with a certificate record
contract CertificateIssuer {
    /// @notice Address of the authorized university (contract deployer)
    address private university;

    /// @notice Structure representing a certificate
    struct Certificate {
        string name;
        string course;
        uint256 issueDate;
    }

    /// @notice Mapping from student ID to their certificate
    mapping(uint256 => Certificate) private certificates;

    /// @notice Emitted when a certificate is issued
    /// @param studentId Unique ID of the student
    /// @param name Student's full name
    /// @param course Name of the course completed
    /// @param date Timestamp of certificate issuance
    event CertificateIssued(
        uint256 indexed studentId,
        string name,
        string course,
        uint256 date
    );

    /// @notice Modifier to restrict access to the university only
    modifier onlyUniversity() {
        require(msg.sender == university, "Not authorized");
        _;
    }

    /// @notice Constructor sets the deployer as the university
    constructor() {
        university = msg.sender;
    }

    /// @notice Issues a certificate to a student
    /// @param studentId Unique ID of the student
    /// @param studentName Full name of the student
    /// @param course Name of the course
    /// @dev Emits a `CertificateIssued` event after successful issuance
    function issueCertificate(
        uint256 studentId,
        string calldata studentName,
        string calldata course
    ) external onlyUniversity {
        certificates[studentId] = Certificate(studentName, course, block.timestamp);
        emit CertificateIssued(studentId, studentName, course, block.timestamp);
    }

    /// @notice Retrieves the certificate details of a student
    /// @param studentId Unique ID of the student
    /// @return name Name on the certificate
    /// @return course Course on the certificate
    /// @return date Issue date of the certificate
    /// @dev Reverts if no certificate is found for the given ID
    function getCertificate(uint256 studentId)
        external
        view
        returns (string memory name, string memory course, uint256 date)
    {
        Certificate storage cert = certificates[studentId];
        require(bytes(cert.name).length > 0, "Certificate not found");
        return (cert.name, cert.course, cert.issueDate);
    }
}
