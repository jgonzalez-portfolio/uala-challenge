//
//  CitiesRemoteDataSource.swift
//  Globuala
//
//  Created by Joni Gonzalez on 18/05/2025.
//

import Foundation

protocol CitiesRemoteDataSource {
    func getCities() async -> Result<[CityDTO], NetworkError>
}

class CitiesRemoteDataSourceImpl: CitiesRemoteDataSource {
    private let networkManager: NetworkManagerProtocol

    init() {
        self.networkManager = NetworkManager()
    }

    func getCities() async -> Result<[CityDTO], NetworkError> {
        return await networkManager.requestCities()
    }
}
