//
//  CitiesRepository.swift
//  Globuala
//
//  Created by Joni Gonzalez on 18/05/2025.
//

protocol CitiesRepository {
    func fetchCities() async throws -> [City]
    func saveFavoriteCity(city: CityId) throws
    func removeFavoriteCity(city: CityId) throws
    func fetchFavoriteCities() -> Set<CityId>
}

final class CitiesRepositoryImpl: CitiesRepository {
    private let localDataSource: CitiesLocalDataSource
    private let remoteDataSource: CitiesRemoteDataSource
    
    init(remoteDataSource: CitiesRemoteDataSource = CitiesRemoteDataSourceImpl()) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = CitiesLocalDataSourceImpl()
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
    
    func saveFavoriteCity(city: CityId) throws {
        do {
            try localDataSource.addCityToFavorites(city)
        } catch {
            throw error
        }
    }
    
    func removeFavoriteCity(city: CityId) throws {
        do {
            try localDataSource.removeCityFromFavorites(city)
        } catch {
            throw error
        }
    }
    
    func fetchFavoriteCities() -> Set<CityId> {
        return localDataSource.getFavoriteCities()
    }
}
    
