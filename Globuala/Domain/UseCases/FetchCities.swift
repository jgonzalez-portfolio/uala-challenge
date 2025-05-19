//
//  FetchCities.swift
//  Globuala
//
//  Created by Joni Gonzalez on 19/05/2025.
//


final class FetchCitiesUseCase {
    var repository: CitiesRepository?
    
    init(repository: CitiesRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> [City] {
        guard let repository = repository else {
            throw FetchCitiesError.repositoryNotFound
        }
        
        return try await repository.fetchCities()
    }
}
