//
//  CityDetailViewModel.swift
//  Globuala
//
//  Created by Joni Gonzalez on 19/05/2025.
//

import Foundation
import SwiftUI

class CityDetailViewModel: ObservableObject {
    
    private var cityId: Int?

    func setCityId(_ id: Int?) {
        self.cityId = id
    }
}
