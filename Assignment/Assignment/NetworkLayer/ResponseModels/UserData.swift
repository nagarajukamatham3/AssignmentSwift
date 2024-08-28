//
//  UserData.swift
//  Assignment
//
//  Created by Raju on 28/08/24.
//

import Foundation

// MARK: - UserData
struct UserData: Codable {
    let page, perPage, total, totalPages: Int?
    let users: [User]?
    let support: Support?

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case users = "data"
        case support
    }
}

// MARK: - User
struct User: Codable, Identifiable {
    let id: Int?
    let email, firstName, lastName: String?
    let avatar: String?

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}

extension User {
    var fullname: String {
        let firstName = self.firstName ?? ""
        let lastName = self.lastName ?? ""
        return firstName + " " + lastName
    }
    
    var getInitials: String {
        return String.getInitials(firstName: self.firstName, lastName: self.lastName)
    }
}

// MARK: - Support
struct Support: Codable {
    let url: String?
    let text: String?
}
