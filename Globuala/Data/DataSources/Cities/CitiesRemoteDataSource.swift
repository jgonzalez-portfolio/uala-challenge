//
//  CitiesRemoteDataSource.swift
//  Globuala
//
//  Created by Joni Gonzalez on 18/05/2025.
//

import Foundation

protocol CitiesRemoteDataSourceProtocol {
    func getCities() async -> Result<[CityDTO], NetworkError>
}

class CitiesRemoteDataSource: CitiesRemoteDataSourceProtocol {
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol = DI.shared.resolve(NetworkManagerProtocol.self)) {
        self.networkManager = networkManager
    }

    func getCities() async -> Result<[CityDTO], NetworkError> {
        return await networkManager.requestCities()
    }
}
