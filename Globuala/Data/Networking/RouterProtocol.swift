//
//  RouterProtocol.swift
//  Globuala
//
//  Created by Joni Gonzalez on 16/05/2025.
//

import Alamofire
import Foundation

public typealias NetworkRouterCompletion<GenericObject: Decodable> = (_ response: Result<GenericObject, AFError>) -> ()

protocol NetworkRouterProtocol: AnyObject {
    associatedtype EndPoint: EndPointType
    func request<GenericObject: Decodable>(expectedData: GenericObject.Type,
                                           from route: EndPoint,
                                           completion: @escaping NetworkRouterCompletion<GenericObject>)
    
    func request<GenericObject: Decodable>(expectedData: GenericObject.Type,
                                           from route: EndPoint) async -> Result<GenericObject, AFError>
}
