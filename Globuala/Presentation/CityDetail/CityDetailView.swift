//
//  CityDetailView.swift
//  Globuala
//
//  Created by Joni Gonzalez on 19/05/2025.
//

import SwiftUI

struct CityDetailView: View {
    @StateObject var viewModel: CityDetailViewModel = DI.shared.resolve(CityDetailViewModel.self)
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CityDetailView()
}
