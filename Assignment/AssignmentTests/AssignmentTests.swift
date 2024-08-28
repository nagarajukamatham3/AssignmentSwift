//
//  AssignmentTests.swift
//  AssignmentTests
//
//  Created by Raju on 28/08/24.
//

import XCTest
@testable import Assignment

final class AssignmentTests: XCTestCase {
    
    func testFetchUserAPI() {
        let expection = expectation(description: "Fetch Users data")
        NetworkManager.shared.fetchUsers(perPage: 12) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response?.perPage, 12)
                XCTAssertNotNil(response?.perPage)
            case .failure(let error):
                XCTAssertNil(error)
            }
            expection.fulfill()
        }
        wait(for: [expection], timeout: 5.0)
    }

}
