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
    @Published var sheet: Sheet?
    @Published var fullScreenCover: FullScreenCover?
    
    func push(page: AppPages) {
        self.path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func presentSheet(_ sheet: Sheet) {
        self.sheet = sheet
    }
    
    func presentFullScreenCover(_ cover: FullScreenCover) {
        self.fullScreenCover = cover
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func dismissCover() {
        self.fullScreenCover = nil
    }
    
    @ViewBuilder
    func build(page: AppPages) -> some View {
        switch page {
        case .main: MainView()
        case .login: LogInView()
        }
    }
    
    @ViewBuilder
    func buildSheet(sheet: Sheet) -> some View {
        switch sheet {
        case .forgotPassword: ForgotPasswordView()
        }
    }
    
    @ViewBuilder
    func buildCover(cover: FullScreenCover) -> some View {
        switch cover {
        case .signup: SignUpView()
        }
    }
}
