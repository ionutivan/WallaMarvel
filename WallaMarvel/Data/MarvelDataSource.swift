import Foundation

protocol MarvelDataSourceProtocol {
    func getHeroes(offset: Int) async throws -> CharacterDataContainer
    func getHeroeDetail(heroeID: Int) async throws -> CharacterDataModel
}

final class MarvelDataSource: MarvelDataSourceProtocol {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func getHeroes(offset: Int) async throws -> CharacterDataContainer {
        return try await apiClient.getHeroes(offset: offset)
    }
    
    func getHeroeDetail(heroeID: Int) async throws -> CharacterDataModel {
        try await apiClient.getHeroeDetail(heroeID: heroeID)
    }
}
