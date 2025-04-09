import Foundation
import MarvelData

public protocol MarvelRepositoryProtocol {
    func getHeroes(offset: Int) async throws -> CharacterDataContainer
    func getHeroeDetail(heroeID: Int) async throws -> CharacterDataModel
}

public final class MarvelRepository: MarvelRepositoryProtocol {
    private let dataSource: MarvelDataSourceProtocol
    
    public init(dataSource: MarvelDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    public func getHeroes(offset: Int) async throws -> CharacterDataContainer  {
        try await dataSource.getHeroes(offset: offset)
    }
    
    public func getHeroeDetail(heroeID: Int) async throws -> CharacterDataModel {
        try await dataSource.getHeroeDetail(heroeID: heroeID)
    }
}
