//
//  CitiesView.swift
//  Globuala
//
//  Created by Joni Gonzalez on 18/05/2025.
//

import SwiftUI

struct CitiesView: View {
    @StateObject private var viewModel: CitiesViewModel = DI.shared.resolve(CitiesViewModel.self)
    @EnvironmentObject private var coordinator: Coordinator
    @State private var selectedCity: Int?
    var body: some View {
        NavigationSplitView {
            Group {
                switch viewModel.state {
                case .idle:
                    Text("Bienvenido a la app")
                case .loading:
                    ProgressView("Cargando...")
                case .success(let cities):
                    List(selection: $selectedCity) {
                        ForEach(cities) { city in
                            Text(city.name)
                                .tag(city.id)
                        }
                    }
                    
                case .failure(let string):
                    Text(string)
                }
            }
            .onAppear {
                if case .idle = viewModel.state {
                    Task { await viewModel.fetchCities() }
                }
            }
            .navigationTitle("Ciudades")
        } detail: {
            if let city = selectedCity {
                coordinator.build(page: .cityDetail(cityId: city))
            } else {
                Text("Selecciona una ciudad")
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    CitiesView()
}
