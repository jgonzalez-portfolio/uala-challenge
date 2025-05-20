//
//  CitiesViewModel.swift
//  Globuala
//
//  Created by Joni Gonzalez on 19/05/2025.
//

import Combine

enum CitiesUIState {
    case idle
    case loading
    case success([City])
    case failure(String)
}

final class CitiesViewModel: ObservableObject {
    
    @Published private(set) var state: CitiesUIState = .idle
    @Published var favoriteCityIDs: Set<Int> = []
    let fetchCitiesUseCase: FetchCitiesUseCase
    
    init(fetchCitiesUseCase: FetchCitiesUseCase) {
        self.fetchCitiesUseCase = fetchCitiesUseCase
    }
    
    
    @MainActor
    func fetchCities() async {
        state = .loading
        do {
            let cities = try await fetchCitiesUseCase.execute()
            state = .success(sortCities(cities))
        } catch {
            state = .failure("Failed to fetch cities")
        }
    }
    
    func sortCities(_ cities: [City]) -> [City] {
        let sortedCities = cities.sorted { $0.name < $1.name }
        return sortedCities
    }
    

    func toggleFavorite(for cityId: Int) {
        if favoriteCityIDs.contains(cityId) {
            favoriteCityIDs.remove(cityId)
        } else {
            favoriteCityIDs.insert(cityId)
        }
    }

    func isFavorite(_ cityId: Int) -> Bool {
        favoriteCityIDs.contains(cityId)
    }
}
