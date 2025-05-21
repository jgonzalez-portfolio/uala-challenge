import Foundation

typealias CityId = Int

enum CitiesLocalDataSourceError: Error, LocalizedError {
    case alreadyExists
    case notFound
    
    var errorDescription: String? {
        switch self {
        case .alreadyExists: return "La ciudad ya está marcada como favorita."
        case .notFound: return "La ciudad no está en favoritos."
        }
    }
}

protocol CitiesLocalDataSource {
    func getFavoriteCities() -> Set<CityId>
    func addCityToFavorites(_ city: CityId) throws
    func removeCityFromFavorites(_ city: CityId) throws
    func isFavorite(_ city: CityId) -> Bool
}

final class CitiesLocalDataSourceImpl: CitiesLocalDataSource {
    
    private let userDefaults = UserDefaults.standard
    private let favoriteCitiesKey = "favoriteCities"
    
    func getFavoriteCities() -> Set<CityId> {
        let ids = userDefaults.array(forKey: favoriteCitiesKey) as? [CityId] ?? []
        return Set(ids)
    }
    
    func addCityToFavorites(_ city: CityId) throws {
        var favorites = getFavoriteCities()
        let (inserted, _) = favorites.insert(city)
        guard inserted else { throw CitiesLocalDataSourceError.alreadyExists }
        save(favorites)
    }
    
    func removeCityFromFavorites(_ city: CityId) throws {
        var favorites = getFavoriteCities()
        guard favorites.contains(city) else { throw CitiesLocalDataSourceError.notFound }
        favorites.remove(city)
        save(favorites)
    }
    
    func isFavorite(_ city: CityId) -> Bool {
        getFavoriteCities().contains(city)
    }
    
    private func save(_ favorites: Set<CityId>) {
        userDefaults.set(Array(favorites), forKey: favoriteCitiesKey)
    }
}
