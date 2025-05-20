//
//  CitiesViewModel.swift
//  Globuala
//
//  Created by Joni Gonzalez on 19/05/2025.
//

import Combine
import Foundation

enum CitiesUIState {
    case idle
    case loading
    case success
    case failure(String)
}

final class CitiesViewModel: ObservableObject {
    
    @Published private(set) var state: CitiesUIState = .idle
    @Published private(set) var favoriteCityIDs: Set<Int> = []
    @Published private(set) var cities: [City] = []
    @Published private(set) var filteredCities: [City] = []
    @Published var searchText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupBindings()
    }
    
    @MainActor
    func fetchCities() async {
        state = .loading
        do {
            let repo = CitiesRepositoryImpl()
            let useCase = FetchCitiesUseCase(repository: repo)
            let citiesResponse = try await useCase.execute()
            cities = sortCities(citiesResponse)
            filterCities(with: searchText)
            state = .success
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
    
    @MainActor
    func findCity(by id: Int) -> City? {
        return cities.first { $0.id == id }
    }
    
    func filterCities(with query: String) {
        if query.isEmpty {
            filteredCities = cities
        } else {
            filteredCities = cities.filter { city in
                let cityString = "\(city.name), \(city.country)"
                return cityString.lowercased().hasPrefix(query.lowercased())
            }
        }
    }
    
    private func setupBindings() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] query in
                self?.filterCities(with: query)
            }
            .store(in: &cancellables)
    }
}
