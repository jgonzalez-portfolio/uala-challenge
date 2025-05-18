//
//  CityDTO.swift
//  Globuala
//
//  Created by Joni Gonzalez on 17/05/2025.
//

struct CityDTO: Codable {
    let id: Int
    let country: String
    let name: String
    let coord: CoordinatesDTO
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case country
        case name
        case coord
    }
}

extension CityDTO {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        country = try container.decode(String.self, forKey: .country)
        name = try container.decode(String.self, forKey: .name)
        coord = try container.decode(CoordinatesDTO.self, forKey: .coord)
    }
}
    
