//
//  Coordinator.swift
//  Globuala
//
//  Created by Joni Gonzalez on 18/05/2025.
//

import Combine
import Foundation
import SwiftUI


class Coordinator: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    
    func push(page: AppPages) {
        self.path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    @ViewBuilder
    func build(page: AppPages) -> some View {
        switch page {
        case .main:
            MainFlowView()
        case .login:
            LogInView()
        case .cities:
            CitiesView()
        case .walkthrough: WalkthroughView()
        }
    }
}
