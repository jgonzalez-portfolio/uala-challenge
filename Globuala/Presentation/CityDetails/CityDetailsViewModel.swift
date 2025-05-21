//
//  CityDetailsViewModel.swift
//  Globuala
//
//  Created by Joni Gonzalez on 21/05/2025.
//

import Combine

class CityDetailsViewModel: ObservableObject {
    
    let city: City
    
    init(city: City) {
        self.city = city
    }
    
    func getCityName() -> String {
        return city.name
    }
    
    func getCityCountry() -> String {
        return city.country
    }
    
    func getCityLat() -> String {
        return String(format: "%.2f", city.coordinates.latitude)
    }
    
    func getCityLon() -> String {
        return String(format: "%.2f", city.coordinates.longitude)
    }
    
    func getCityCoordinates() -> String {
        return "\(city.coordinates.latitude), \(city.coordinates.longitude)"
    }
}
