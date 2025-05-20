//
//  CitiesRepository.swift
//  Globuala
//
//  Created by Joni Gonzalez on 18/05/2025.
//

protocol CitiesRepository {
    func fetchCities() async throws -> [City]
}

final class CitiesRepositoryImpl: CitiesRepository {
    private let remoteDataSource: CitiesRemoteDataSource
    
    init() {
        self.remoteDataSource = CitiesRemoteDataSourceImpl()
    }
    
    func fetchCities() async throws -> [City] {
        let result = await remoteDataSource.getCities()
        switch result {
        case .success(let cities):
            return cities.compactMap { $0.toEntity() }
        case .failure(let error):
            throw error
        }
    }
}
    
