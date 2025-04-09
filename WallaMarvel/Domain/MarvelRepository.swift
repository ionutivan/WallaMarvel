import Foundation

protocol MarvelRepositoryProtocol {
    func getHeroes(offset: Int) async throws -> CharacterDataContainer
    func getHeroeDetail(heroeID: Int) async throws -> CharacterDataModel
}

final class MarvelRepository: MarvelRepositoryProtocol {
    private let dataSource: MarvelDataSourceProtocol
    
    init(dataSource: MarvelDataSourceProtocol = MarvelDataSource()) {
        self.dataSource = dataSource
    }
    
    func getHeroes(offset: Int) async throws -> CharacterDataContainer  {
        try await dataSource.getHeroes(offset: offset)
    }
    
    func getHeroeDetail(heroeID: Int) async throws -> CharacterDataModel {
        try await dataSource.getHeroeDetail(heroeID: heroeID)
    }
}
