//
//  RouterProtocol.swift
//  Globuala
//
//  Created by Joni Gonzalez on 16/05/2025.
//

import Foundation

protocol NetworkRouterProtocol: AnyObject {
    associatedtype EndPoint: EndPointType
    func request<GenericObject: Codable>(expectedData: GenericObject.Type,
                                           from route: EndPoint) async throws -> GenericObject
}
