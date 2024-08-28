//
//  NetworkManager.swift
//  Assignment
//
//  Created by Raju on 28/08/24.
//

import Foundation
import Moya

protocol Networkable {
    var provider: MoyaProvider<APIs> { get }
    func fetchUsers(perPage: Int, completion: @escaping (Result<UserData?, Error>) -> ())
}

public class NetworkManager: Networkable {
    static let shared: NetworkManager = {
        let instance = NetworkManager()
        return instance
    }()
    
    var provider = MoyaProvider<APIs>(plugins: [NetworkLoggerPlugin()])
    
    func fetchUsers(perPage: Int, completion: @escaping (Result<UserData?, Error>) -> ()) {
        request(target: .users(perPage: perPage), completion: completion)
    }
}

private extension NetworkManager {
    private func request<T: Decodable>(target: APIs, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
