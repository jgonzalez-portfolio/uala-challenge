//
//  EndpointType.swift
//  Globuala
//
//  Created by Joni Gonzalez on 16/05/2025.
//

import Foundation

typealias Parameters = [String: Any]
typealias HTTPHeaders = [String: String]

protocol EndPointType {
    var baseURL: URL? { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum HTTPTask {
    case request
}

