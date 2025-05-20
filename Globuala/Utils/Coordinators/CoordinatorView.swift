//
//  AppCoordinatorView.swift
//  Globuala
//
//  Created by Joni Gonzalez on 18/05/2025.
//


import SwiftUI

struct AppCoordinatorView: View {
    
    @StateObject private var sessionManager = DI.shared.resolve(SessionManager.self)
    @StateObject private var coordinator = DI.shared.resolve(Coordinator.self)

    var body: some View {
        Group {
            if sessionManager.isLoggedIn {
                MainFlowView()
            } else {
                WalkthroughFlow()
            }
        }
        .environmentObject(sessionManager)
        .environmentObject(coordinator)

    }
}

#Preview {
    AppCoordinatorView()
}
