import Foundation

protocol MarvelRepositoryProtocol {
    func getHeroes(completionBlock: @escaping (CharacterDataContainer) -> Void)
    func getHeroeDetail(heroeID: Int) async throws -> CharacterDataModel
}

final class MarvelRepository: MarvelRepositoryProtocol {
    private let dataSource: MarvelDataSourceProtocol
    
    init(dataSource: MarvelDataSourceProtocol = MarvelDataSource()) {
        self.dataSource = dataSource
    }
    
    func getHeroes(completionBlock: @escaping (CharacterDataContainer) -> Void) {
        dataSource.getHeroes(completionBlock: completionBlock)
    func getHeroeDetail(heroeID: Int) async throws -> CharacterDataModel {
        try await dataSource.getHeroeDetail(heroeID: heroeID)
    }
}
