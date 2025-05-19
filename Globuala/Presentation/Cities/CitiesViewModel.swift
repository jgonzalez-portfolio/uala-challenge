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
    let fetchCitiesUseCase: FetchCitiesUseCase
    
    init(fetchCitiesUseCase: FetchCitiesUseCase) {
        self.fetchCitiesUseCase = fetchCitiesUseCase
    }
    
    
    @MainActor
    func fetchCities() async {
        state = .loading
        do {
            let cities = try await fetchCitiesUseCase.execute()
            state = .success(cities)
        } catch {
            state = .failure("Failed to fetch cities")
        }
    }
}
