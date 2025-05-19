//
//  AppPages.swift
//  Globuala
//
//  Created by Joni Gonzalez on 18/05/2025.
//

enum AppPages: Hashable {
    case main
    case login
    case cities
}

enum Sheet: String, Identifiable {
    var id: String {
        self.rawValue
    }
    
    case forgotPassword
}

enum FullScreenCover: String, Identifiable {
    var id: String {
        self.rawValue
    }
    
    case signup
}
