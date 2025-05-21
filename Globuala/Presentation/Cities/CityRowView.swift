//
//  CityRowView.swift
//  Globuala
//
//  Created by Joni Gonzalez on 20/05/2025.
//

import SwiftUI

struct CityRowView: View {
    @ObservedObject var viewModel: CityRowViewModel
    let isFavorite: Bool
    let onFavoriteToggle: () -> Void
    @State private var showCityDetails = false

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.getTitleRow())
                    .font(.headline)
                Text(viewModel.getSubtitleRow())
                    .font(.subheadline)
            }            
            Spacer()
            HStack {
                Button {
                    showCityDetails = true
                } label: {
                    Image(systemName: "info.circle")
                        .foregroundStyle(.blue)
                }
                .buttonStyle(.borderless)
                FavoriteButton(cityId: viewModel.getCityId(),
                               isFavorite: isFavorite,
                               onToggle: onFavoriteToggle)
            }
        }
        .sheet(isPresented: $showCityDetails) {
            CityDetailsView(viewModel: .init(city: viewModel.city))
        }
    }
}

#Preview {
    CityRowView(viewModel:
            .init(city:
                    .init(id: 123,
                          name: "Demo City",
                          coordinates: .init(latitude: 0.0, longitude: 0.0),
                          country: "ARG")),
                isFavorite: false,
                onFavoriteToggle: {})
}
