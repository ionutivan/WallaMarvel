import Foundation

public protocol MarvelDataSourceProtocol {
    func getHeroes(offset: Int) async throws -> CharacterDataContainer
    func getHeroeDetail(heroeID: Int) async throws -> CharacterDataModel
}

public final class MarvelDataSource: MarvelDataSourceProtocol {
    private let apiClient: APIClientProtocol
    
    public init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    public func getHeroes(offset: Int) async throws -> CharacterDataContainer {
        return try await apiClient.getHeroes(offset: offset)
    }
    
    public func getHeroeDetail(heroeID: Int) async throws -> CharacterDataModel {
        try await apiClient.getHeroeDetail(heroeID: heroeID)
    }
}
