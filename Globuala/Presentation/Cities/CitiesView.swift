//
//  CitiesView.swift
//  Globuala
//
//  Created by Joni Gonzalez on 18/05/2025.
//

import SwiftUI
import MapKit

struct CitiesView: View {
    
    @StateObject private var viewModel: CitiesViewModel = .init()
    @State private var selectedCity: Int?
    @State private var searchText: String = ""
    @State private var mapPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 0.0,
                                           longitude: 0.0),
            span: MKCoordinateSpan(latitudeDelta: 10.0,
                                   longitudeDelta: 10.0)
        )
    )
    
    struct Constants {
        static let title = "Ciudades"
        static let loading = "Cargando..."
        static let selectCity = "Selecciona una ciudad"
        static let welcome = "Bienvenido a la app"
        static let icon = "heart"
        static let iconFill = "heart.fill"
    }
    
    var body: some View {
        NavigationSplitView {
            Group {
                switch viewModel.state {
                case .idle:
                    buildIdle()
                case .loading:
                    buildLoading()
                case .success:
                    buildCities()
                case .failure(let string):
                    buildError(string)
                }
            }
            .navigationTitle(Constants.title)
            .searchable(text: $viewModel.searchText, prompt: "Buscar ciudad")
            .onChange(of: viewModel.searchText, { _, newValue in
                viewModel.filterCities(with: newValue)
            })
        } detail: {
            buildMap()
        }
        .onChange(of: selectedCity, { _, newCityId in
            selectedCity = newCityId
            guard let id = newCityId,
                  let city = viewModel.findCity(by: id) else { return }
            mapPosition = .region(MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: city.coordinates.latitude,
                                               longitude: city.coordinates.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            ))
        })
        .task {
            if case .idle = viewModel.state {
                await viewModel.fetchCities()
            }
        }
    }
    
    @ViewBuilder
    func buildMap() -> some View {
        if let cityId = selectedCity,
           let city = viewModel.findCity(by: cityId) {
            Map(position: $mapPosition) {
                Marker("Seleccionado",
                       coordinate: .init(latitude: city.coordinates.latitude,
                                         longitude: city.coordinates.longitude)
                )
            }
            .navigationTitle(city.name)
        } else {
            Text(Constants.selectCity)
                .foregroundStyle(.secondary)
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
    func buildCities() -> some View {
        List(selection: $selectedCity) {
            ForEach(viewModel.filteredCities) { city in
                CityRowView(viewModel: .init(city: city),
                            isFavorite: viewModel.isFavorite(city.id),
                            onFavoriteToggle: {
                    viewModel.toggleFavorite(for: city.id)
                })
                
                .tag(city.id)
            }
            if viewModel.hasMorePages {
                ProgressView()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .onAppear {
                        viewModel.loadNextPage()
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
