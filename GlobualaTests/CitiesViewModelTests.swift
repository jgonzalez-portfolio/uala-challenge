import XCTest
import Combine
@testable import Globuala

final class CitiesViewModelTests: XCTestCase {
    var viewModel: CitiesViewModel!
    var mockRepository: MockCitiesRepository!
    var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        mockRepository = MockCitiesRepository()
        let useCase = FetchCitiesUseCase(repository: mockRepository)
        viewModel = CitiesViewModel(useCase: useCase, pageSize: 1)
    }

    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        cancellables.removeAll()
        super.tearDown()
    }

    func testFetchCities_Success() async {
        let mockCities = [
            City(id: 1, name: "Buenos Aires", coordinates: .init(latitude: 1.0, longitude: 2.0), country: "ARG"),
            City(id: 2, name: "Rosario", coordinates: .init(latitude: 2.0, longitude: 3.0), country: "ARG")
        ]
        mockRepository.mockCities = mockCities
        await viewModel.fetchCities()
        sleep(1)
        XCTAssertEqual(viewModel.state, .success)
        XCTAssertEqual(viewModel.cities.count, 2)
        viewModel.loadNextPage()
        XCTAssertEqual(viewModel.filteredCities.count, 2)
    }

    func testFetchCities_Failure() async {
        mockRepository.shouldFail = true
        await viewModel.fetchCities()
        sleep(1)
        if case .failure(let message) = viewModel.state {
            XCTAssertEqual(message, "Failed to fetch cities")
        } else {
            XCTFail("Expected failure state")
        }
    }

    func testSortCities() {
        let unsortedCities = [
            City(id: 1, name: "Buenos Aires", coordinates: .init(latitude: 1.0, longitude: 2.0), country: "ARG"),
            City(id: 2, name: "Amsterdam", coordinates: .init(latitude: 2.0, longitude: 3.0), country: "NL")
        ]
        let sortedCities = viewModel.sortCities(unsortedCities)
        XCTAssertEqual(sortedCities[0].name, "Amsterdam")
        XCTAssertEqual(sortedCities[1].name, "Buenos Aires")
    }

    func testToggleFavorite() {
        let cityId = 1
        viewModel.toggleFavorite(for: cityId)
        XCTAssertTrue(viewModel.isFavorite(cityId))
        viewModel.toggleFavorite(for: cityId)
        XCTAssertFalse(viewModel.isFavorite(cityId))
    }

    func testLoadNextPage() async {
        viewModel.pageSize = 20
        let mockCities = Array(1...30).map {
            City(id: $0, name: "City \($0)", coordinates: .init(latitude: 1.0, longitude: 2.0), country: "Country \($0 % 5)")
        }
        mockRepository.mockCities = mockCities
        await viewModel.fetchCities()
        sleep(1)
        XCTAssertEqual(viewModel.currentPage, 1)
        XCTAssertEqual(viewModel.filteredCities.count, 20)
        XCTAssertTrue(viewModel.hasMorePages)
        viewModel.loadNextPage()
        XCTAssertEqual(viewModel.currentPage, 2)
        XCTAssertEqual(viewModel.filteredCities.count, 30)
        XCTAssertFalse(viewModel.hasMorePages)
    }

    func testFilterCities() async {
        let mockCities = [
            City(id: 1, name: "New Delhi", coordinates: .init(latitude: 1.0, longitude: 2.0), country: "India"),
            City(id: 2, name: "New York", coordinates: .init(latitude: 2.0, longitude: 3.0), country: "USA"),
            City(id: 3, name: "London", coordinates: .init(latitude: 3.0, longitude: 4.0), country: "UK")
        ]
        mockRepository.mockCities = mockCities
        viewModel.pageSize = 20
        await viewModel.fetchCities()
        sleep(1)
        viewModel.filterCities(with: "New")
        XCTAssertEqual(viewModel.filteredCities.count, 2)
        XCTAssertTrue(viewModel.filteredCities.contains(where: { $0.name == "New Delhi" }))
        XCTAssertTrue(viewModel.filteredCities.contains(where: { $0.name == "New York" }))
        viewModel.filterCities(with: "")
        sleep(1)
        XCTAssertEqual(viewModel.filteredCities.count, 0)
    }

    func testFindCityById() async {
        let mockCities = [
            City(id: 1, name: "Buenos Aires", coordinates: .init(latitude: 1.0, longitude: 2.0), country: "ARG"),
            City(id: 2, name: "Rosario", coordinates: .init(latitude: 2.0, longitude: 3.0), country: "ARG")
        ]
        mockRepository.mockCities = mockCities
        await viewModel.fetchCities()
        sleep(1)
        let foundCity = await viewModel.findCity(by: 2)
        XCTAssertNotNil(foundCity)
        XCTAssertEqual(foundCity?.name, "Rosario")
        let notFoundCity = await viewModel.findCity(by: 99)
        XCTAssertNil(notFoundCity)
    }
    
    func testSearchTextPublisher() {
        let expectation = XCTestExpectation(description: "Filter cities called after search text update")
        viewModel.searchText = "Bue"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}

class MockCitiesRepository: CitiesRepository {
    var mockCities: [City] = []
    var shouldFail = false
    
    func fetchCities() async throws -> [City] {
        if shouldFail {
            throw NSError(domain: "MockError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch cities"])
        }
        return mockCities
    }
}

extension CitiesUIState: Equatable {
    public static func == (lhs: CitiesUIState, rhs: CitiesUIState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.loading, .loading), (.success, .success):
            return true
        case (.failure(let lhsMessage), (.failure(let rhsMessage))):
            return lhsMessage == rhsMessage
        default:
            return false
        }
    }
}
