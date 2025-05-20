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
                    buildIdle()
                case .loading:
                    buildLoading()
                case .success(let cities):
                    buildCities(cities)
                case .failure(let string):
                    buildError(string)
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
    
    @ViewBuilder
    func buildIdle() -> some View {
        Text("Bienvenido a la app")
    }
    
    @ViewBuilder
    func buildLoading() -> some View {
        ProgressView("Cargando...")
    }
    
    @ViewBuilder
    func buildCities(_ cities: [City]) -> some View {
        List(selection: $selectedCity) {
            ForEach(cities) { city in
                Text(city.name)
                    .tag(city.id)
            }
        }
    }
    
    @ViewBuilder
    func buildError(_ error: String) -> some View {
        Text(error)
            .foregroundStyle(.red)
            .padding()
    }
}

#Preview {
    CitiesView()
}
