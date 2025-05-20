//
//  Ghist.swift
//  Globuala
//
//  Created by Joni Gonzalez on 16/05/2025.
//

import Foundation

public protocol FoodEndpointParameters {
    var toDictionary: [String: Any] { get }
}

enum NetworkEnvironment {
    case qa
    case production
    case mock
}

public enum UalaGistAPI {
    case getCities
}

extension UalaGistAPI: EndPointType {
    
    var baseURL: URL? {
        switch NetworkManager.environment {
        case .qa: return URL(string: "")
        case .production: return URL(string: "https://gist.githubusercontent.com")
        case .mock: return URL(string: "http://localhost:3000")
        }
    }
    
    var path: String {
        switch self {
        case .getCities:
            return "/hernan-uala/dce8843a8edbe0b0018b32e137bc2b3a/raw/0996accf70cb0ca0e16f9a99e0ee185fafca7af1/cities.json"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        default:
            return nil
        }
    }
    
    var task: HTTPTask {
        switch self {
        default:
            return .request
        }
    }
    
    var parameters: Parameters? {

        switch self {
        default:
            return [:]
        }
    }
    
}
