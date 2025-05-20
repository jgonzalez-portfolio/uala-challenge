//
//  DI.swift
//  Globuala
//
//  Created by Joni Gonzalez on 18/05/2025.
//

import Foundation
import Swinject

class DI {

    static let shared = DI()

    private var container = buildContainer()

    func resolve<T>(_ type: T.Type) -> T {
        container.resolve(T.self)!
    }

    func setDependencyContainer(_ container: Container) {
        self.container = container
    }
}

func buildContainer() -> Container {
    let container = Container()
    
    container.register(SessionManager.self) { _ in
        return SessionManager()
    }
    
    container.register(Coordinator.self) { _ in
        return Coordinator()
    }

    container.register(NetworkManagerProtocol.self) { _ in
        return NetworkManager()
    }

    container.register(CitiesRemoteDataSource.self) { resolver in
        let networkManager = resolver.resolve(NetworkManagerProtocol.self)!
        return CitiesRemoteDataSourceImpl(networkManager: networkManager)
    }
    
    container.register(CitiesRepository.self) { resolver in
        return CitiesRepositoryImpl(dataSource: resolver.resolve(CitiesRemoteDataSource.self)!)
    }
    
    container.register(FetchCitiesUseCase.self) { resolver in
        return FetchCitiesUseCase(repository: resolver.resolve(CitiesRepository.self)!)
    }
    
    container.register(CitiesViewModel.self) { resolver in
        return CitiesViewModel(fetchCitiesUseCase: resolver.resolve(FetchCitiesUseCase.self)!)
    }
    
    container.register(CityDetailViewModel.self) { resolver in
        return CityDetailViewModel()
    }
    
    return container
}
