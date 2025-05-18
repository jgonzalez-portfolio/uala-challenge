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

    container.register(Coordinator.self) { _ in
        return Coordinator()
    }

    container.register(NetworkManagerProtocol.self) { _ in
        return NetworkManager()
    }

    container.register(CitiesRemoteDataSourceProtocol.self) { resolver in
        let networkManager = resolver.resolve(NetworkManagerProtocol.self)!
        return CitiesRemoteDataSource(networkManager: networkManager)
    }

    return container
}
