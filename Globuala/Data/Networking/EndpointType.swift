//
//  EndpointType.swift
//  Globuala
//
//  Created by Joni Gonzalez on 16/05/2025.
//

import Alamofire

protocol EndPointType {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var task: HTTPTask? { get }
    var parameters: Parameters? { get }
}

extension EndPointType {
    var endpointURL: URLConvertible {
        return self.baseURL.appending(path)
    }
}

