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
    
    struct Constants {
        static let title = "Ciudades"
        static let loading = "Cargando..."
        static let selectCity = "Selecciona una ciudad"
        static let welcome = "Bienvenido a la app"
    }
    
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
            .navigationTitle(Constants.title)
        } detail: {
            if let city = selectedCity {
                coordinator.build(page: .cityDetail(cityId: city))
            } else {
                Text(Constants.selectCity)
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    @ViewBuilder
    func buildIdle() -> some View {
        Text(Constants.welcome)
    }
    
    @ViewBuilder
    func buildLoading() -> some View {
        ProgressView(Constants.loading)
    }
    
    @ViewBuilder
    func buildCities(_ cities: [City]) -> some View {
        List(selection: $selectedCity) {
            ForEach(cities) { city in
                VStack(alignment: .leading) {
                    Text("\(city.name), \(city.country)")
                        .tag(city.id)
                        .font(.headline)
                    Text("Lat: \(city.coordinates.latitude), Lon: \(city.coordinates.longitude)")
                        .font(.subheadline)
                        
                }
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
