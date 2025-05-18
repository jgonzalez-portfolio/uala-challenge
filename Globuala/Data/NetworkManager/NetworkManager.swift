//
//  NetworkManager.swift
//  Globuala
//
//  Created by Joni Gonzalez on 17/05/2025.
//

protocol NetworkManagerProtocol {
    func requestCities() async -> Result<[CityDTO], NetworkError>
}

struct NetworkManager: NetworkManagerProtocol {
    
    private let routerAPI = Router<UalaGistAPI>()
    
    static let environment: NetworkEnvironment = .production
    
    func requestCities() async -> Result<[CityDTO], NetworkError> {
        do {
            let response = try await routerAPI.request(expectedData: [CityDTO].self, from: .getCities)
            return .success(response)
        } catch {
            return .failure(NetworkError.failWithQuery)
        }
    }
}
