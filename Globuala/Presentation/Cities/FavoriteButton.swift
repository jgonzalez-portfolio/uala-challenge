//
//  FavoriteButton.swift
//  Globuala
//
//  Created by Joni Gonzalez on 20/05/2025.
//

import SwiftUI

struct FavoriteButton: View {
    let cityId: Int
    let isFavorite: Bool
    let onToggle: () -> Void
    
    var body: some View {
        Button(action: onToggle) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundStyle(isFavorite ? .red : .secondary)
        }
        .buttonStyle(.borderless)
    }
}

#Preview {
    FavoriteButton(cityId: 123, isFavorite: false, onToggle: {})
}
