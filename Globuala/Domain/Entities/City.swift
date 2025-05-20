//
//  City.swift
//  Globuala
//
//  Created by Joni Gonzalez on 18/05/2025.
//

struct City: Identifiable, Hashable {
    let id: Int
    let name: String
    let coordinates: Coordinates
    let country: String

    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
