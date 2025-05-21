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
    @Published private(set) var currentPage = 0
    @Published private(set) var hasMorePages = true
    @Published var searchText: String = ""
    
    let useCase: FetchCitiesUseCase
    let saveCityUseCase: SaveFavoriteCityUseCase
    let removeCityUseCase: RemoveFavoriteCityUseCase
    let getFavoriteCitiesUseCase: GetFavoriteCitiesUseCase

    private var cancellables = Set<AnyCancellable>()
    var pageSize: Int
    private var isLoading = false
    
    init(useCase: FetchCitiesUseCase = .init(repository: CitiesRepositoryImpl()), pageSize: Int = 20) {
        self.useCase = useCase
        self.pageSize = pageSize
        self.saveCityUseCase = SaveFavoriteCityUseCase(repository: CitiesRepositoryImpl())
        self.removeCityUseCase = RemoveFavoriteCityUseCase(repository: CitiesRepositoryImpl())
        self.getFavoriteCitiesUseCase = GetFavoriteCitiesUseCase(repository: CitiesRepositoryImpl())
        setupBindings()
    }
    
    @MainActor
    func fetchCities() async {
        state = .loading
        let favoritesLocalSaved = getFavoriteCitiesUseCase.execute()
        self.favoriteCityIDs = favoritesLocalSaved
        Task {
            do {
                let citiesResponse = try await useCase.execute()
                cities = sortCities(citiesResponse)
                currentPage = 0
                hasMorePages = cities.count > pageSize
                loadNextPage()
                filterCities(with: searchText)
                state = .success
            } catch {
                state = .failure("Failed to fetch cities")
            }
        }
    }
    
    func loadNextPage() {
        guard hasMorePages else { return }
        
        let startIndex = currentPage * pageSize
        let endIndex = min(startIndex + pageSize, cities.count)
        
        if startIndex < cities.count {
            let newCities = Array(cities[startIndex..<endIndex])
            filteredCities.append(contentsOf: newCities)
            currentPage += 1
            hasMorePages = endIndex < cities.count
        }
    }
    
    func sortCities(_ cities: [City]) -> [City] {
        let sortedCities = cities.sorted { $0.name < $1.name }
        return sortedCities
    }
    

    func toggleFavorite(for cityId: Int) {
        do {
            if favoriteCityIDs.contains(cityId) {
                favoriteCityIDs.remove(cityId)
                try removeCityUseCase.execute(city: cityId)

            } else {
                favoriteCityIDs.insert(cityId)
                try saveCityUseCase.execute(city: cityId)
            }
        } catch {
            print("Error toggling favorite: \(error)")
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
            currentPage = 0
            filteredCities = []
            hasMorePages = cities.count > pageSize
            loadNextPage()
        } else {
            let filtered = cities.filter { city in
                let cityString = "\(city.name), \(city.country)"
                return cityString.lowercased().hasPrefix(query.lowercased())
            }
            filteredCities = Array(filtered.prefix(pageSize))
            hasMorePages = filtered.count > pageSize
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
