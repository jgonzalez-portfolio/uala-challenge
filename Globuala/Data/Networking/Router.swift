//
//  Router.swift
//  Globuala
//
//  Created by Joni Gonzalez on 16/05/2025.
//

import Foundation

class Router<EndPoint: EndPointType>: NetworkRouterProtocol {
    
    func request<GenericObject>(expectedData: GenericObject.Type,
                                from route: EndPoint) async throws -> GenericObject where GenericObject : Codable {
        guard let url = route.baseURL else {
            throw NetworkError.missingUrl
        }
        let endpoint = url.appending(path: route.path)
        do {
            let (data, response) = try await URLSession.shared.data(for: .init(url: endpoint))
            let decodedResponse = try JSONDecoder().decode(GenericObject.self, from: data)
            
            return decodedResponse
        } catch {
            throw NetworkError.unwrapperError
        }
    }
}
