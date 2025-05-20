//
//  AppCoordinatorView.swift
//  Globuala
//
//  Created by Joni Gonzalez on 18/05/2025.
//


import SwiftUI

struct AppCoordinatorView: View {
    
    @StateObject private var sessionManager = DI.shared.resolve(SessionManager.self)
    
    var body: some View {
//        NavigationStack(path: $coordinator.path) {
//            coordinator.build(page: .cities)
//                .navigationDestination(for: AppPages.self) { page in
//                    coordinator.build(page: page)
//                }
//                .sheet(item: $coordinator.sheet) { sheet in
//                    coordinator.buildSheet(sheet: sheet)
//                }
//                .fullScreenCover(item: $coordinator.fullScreenCover) { item in
//                    coordinator.buildCover(cover: item)
//                }
//        }
//        .environmentObject(coordinator)
        
        Group {
            if sessionManager.isLoggedIn {
                MainFlowView()
            } else {
                WalkthroughFlow()
            }
        }
        .environmentObject(sessionManager)
    }
}

#Preview {
    AppCoordinatorView()
}
