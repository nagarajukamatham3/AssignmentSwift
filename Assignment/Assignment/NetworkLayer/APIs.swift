//
//  APIs.swift
//  Assignment
//
//  Created by Raju on 28/08/24.
//

import Foundation
import Moya

enum APIs {
    case users(perPage: Int)
}

extension APIs: TargetType {
   
    public var baseURL: URL {
        let baseURL = "https://reqres.in/api/"
        return URL(string: baseURL)  ?? URL(string: "https://reqres.in/api/")!
    }
    
    public var path: String {
        switch self {
        case .users: return "users"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .users: return .get
        }
    }
}

extension APIs {
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    public var task: Task {
        switch self {
        case .users(let perPage):
            var params: [String: Any] = [:]
            params["per_page"] = "\(perPage)"
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
