//
//  CoordinatesDTOMapper.swift
//  Globuala
//
//  Created by Joni Gonzalez on 18/05/2025.
//

extension CoordinatesDTO {
    func toEntity() -> Coordinates {
        return Coordinates(
            latitude: lat,
            longitude: lon
        )
    }
}
