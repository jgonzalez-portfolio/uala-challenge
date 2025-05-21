//
//  CityDetailsView.swift
//  Globuala
//
//  Created by Joni Gonzalez on 20/05/2025.
//

import SwiftUI

struct CityDetailsView: View {
    @StateObject var viewModel: CityDetailsViewModel
    @Environment(\.dismiss) private var dismiss
    
    struct Constants {
        static let cityDetailsTitle = "Detalles de "
        static let cityDetailsTitleSection = "Información General"
        static let coordinatesTitleSection = "Coordenadas"
        static let cityNameLabel = "Ciudad"
        static let countryNameLabel = "País"
        static let latitudeLabel = "Latitud"
        static let longitudeLabel = "Longitud"
        static let closeButtonTitle = "Cerrar"
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(Constants.cityDetailsTitleSection) {
                    LabeledContent(Constants.cityNameLabel,
                                   value: viewModel.getCityName())
                    LabeledContent(Constants.countryNameLabel,
                                   value: viewModel.getCityCountry())
                }
                
                Section(Constants.coordinatesTitleSection) {
                    LabeledContent(Constants.latitudeLabel,
                                   value: viewModel.getCityLat())
                    LabeledContent(Constants.longitudeLabel,
                                   value: viewModel.getCityLon())
                }
            }
            .navigationTitle(Constants.cityDetailsTitle + viewModel.getCityName())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(Constants.closeButtonTitle) {
                        dismiss()
                    }
                }
            }
        }
    }
}
#Preview {
    CityDetailsView(viewModel: .init(city: .init(id: 123, name: "Demo City", coordinates: .init(latitude: 0.0, longitude: 0.0), country: "ARG")))
}
