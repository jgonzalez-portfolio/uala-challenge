//
//  Router.swift
//  Globuala
//
//  Created by Joni Gonzalez on 16/05/2025.
//

import Foundation
import Alamofire

class Router<EndPoint: EndPointType>: NetworkRouterProtocol {
    
    func request<GenericObject>(expectedData: GenericObject.Type,
                                from route: EndPoint) async throws -> GenericObject where GenericObject : Codable {
        
//        do {
//            let request = AF.request(route.endpointURL,
//                                     method: route.httpMethod,
//                                     parameters: route.parameters,
//                                     headers: route.headers)
//            
//            let dataTask = request.validate().serializingDecodable(GenericObject.self)
//            
//            let response = await dataTask.response
//            
//            switch response.result {
//            case .success(let value):
//                return value
//            case .failure(let error):
//                throw error
//            }
//        } catch {
//            print("Error: \(error)")
//            throw error
//        }
        
        let result = await AF.download(route.endpointURL).validate().serializingData().result
        
        switch result {
        case .success(let data):
            let jsonDecoder = JSONDecoder()
            return try jsonDecoder.decode(GenericObject.self, from: data)
        case .failure(let failure):
            throw failure
        }
    }
}
