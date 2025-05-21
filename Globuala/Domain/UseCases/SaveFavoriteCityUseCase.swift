//
//  SaveFavoriteCityUseCase.swift
//  Globuala
//
//  Created by Joni Gonzalez on 21/05/2025.
//

class SaveFavoriteCityUseCase {
    private let repository: CitiesRepository
    
    init(repository: CitiesRepository = CitiesRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(city: CityId) throws {
        try repository.saveFavoriteCity(city: city)
    }
        
}



class RemoveFavoriteCityUseCase {
    private let repository: CitiesRepository
    
    init(repository: CitiesRepository = CitiesRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(city: CityId) throws {
        try repository.removeFavoriteCity(city: city)
    }
        
}

class GetFavoriteCitiesUseCase {
    private let repository: CitiesRepository
    
    init(repository: CitiesRepository = CitiesRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute() -> Set<CityId> {
        let favorites = repository.fetchFavoriteCities()
        return favorites
    }
        
}
