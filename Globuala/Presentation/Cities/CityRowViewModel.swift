//
//  CityRowViewModel.swift
//  Globuala
//
//  Created by Joni Gonzalez on 21/05/2025.
//
import Combine

class CityRowViewModel: ObservableObject {
    
    let city: City
    
    init(city: City) {
        self.city = city
    }
    
    func getTitleRow() -> String {
        return "\(city.name), \(city.country)"
    }
    
    func getSubtitleRow() -> String {
        return "Lat: \(city.coordinates.latitude), Lon: \(city.coordinates.longitude)"
    }
    
    func getCityId() -> Int {
        return city.id
    }
}
    
