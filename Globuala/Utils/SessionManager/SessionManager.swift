//
//  SessionManager.swift
//  Globuala
//
//  Created by Joni Gonzalez on 19/05/2025.
//

import Foundation
import Combine

final class SessionManager: ObservableObject {
    
    @Published var isLoggedIn: Bool = false
    
    func login() {
        isLoggedIn = true
    }
}
