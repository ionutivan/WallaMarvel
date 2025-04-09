import Foundation

protocol MarvelDataSourceProtocol {
    func getHeroes(completionBlock: @escaping (CharacterDataContainer) -> Void)
    func getHeroeDetail(heroeID: Int) async throws -> CharacterDataModel
}

final class MarvelDataSource: MarvelDataSourceProtocol {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func getHeroes(completionBlock: @escaping (CharacterDataContainer) -> Void) {
        return apiClient.getHeroes(completionBlock: completionBlock)
    func getHeroeDetail(heroeID: Int) async throws -> CharacterDataModel {
        try await apiClient.getHeroeDetail(heroeID: heroeID)
    }
}
