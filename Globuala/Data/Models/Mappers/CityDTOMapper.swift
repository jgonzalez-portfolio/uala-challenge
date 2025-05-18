//
//  CityDTOMapper.swift
//  Globuala
//
//  Created by Joni Gonzalez on 18/05/2025.
//

extension CityDTO {
    func toEntity() -> City {
        return City(
            id: id,
            name: name,
            coordinates: coord.toEntity(),
            country: country
        )
    }
}
