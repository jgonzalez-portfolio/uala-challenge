//
//  CitiesView.swift
//  Globuala
//
//  Created by Joni Gonzalez on 18/05/2025.
//

import SwiftUI

struct CitiesView: View {
    @StateObject private var viewModel: CitiesViewModel = DI.shared.resolve(CitiesViewModel.self)
    var body: some View {
            Group {
                switch viewModel.state {
                case .idle:
                    Text("Bienvenido a la app")
                case .loading:
                    ProgressView("Cargando...")
                case .success(let cities):
                    List(cities, id: \.id) { city in
                        Text(city.name)
                    }
                case .failure(let string):
                    Text(string)
                }
            }
            .onAppear {
                Task { await viewModel.fetchCities() }
            }
            .navigationTitle("Ciudades")
        
    }
}

#Preview {
    CitiesView()
}
