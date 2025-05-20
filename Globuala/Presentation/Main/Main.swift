//
//  Main.swift
//  Globuala
//
//  Created by Joni Gonzalez on 18/05/2025.
//

import SwiftUI

struct MainFlowView: View {
    @EnvironmentObject private var coordinator: Coordinator
    var body: some View {
        coordinator.build(page: .cities)
    }
}

#Preview {
    AppCoordinatorView()
}
