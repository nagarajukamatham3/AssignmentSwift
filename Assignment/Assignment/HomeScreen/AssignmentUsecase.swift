//
//  AssignmentUsecase.swift
//  Assignment
//
//  Created by Raju on 28/08/24.
//

import Foundation

protocol AssignmentUsecaseProtocol {
    func fetchUserList(perPage: Int, completion: @escaping (Result<UserData?, Error>) -> Void)
}

class AssignmentUsecase: AssignmentUsecaseProtocol {
    func fetchUserList(perPage: Int, completion: @escaping (Result<UserData?, Error>) -> Void) {
        NetworkManager.shared.fetchUsers(perPage: perPage) { response in
            completion(response)
        }
    }
}
