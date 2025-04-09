import Foundation
import MarvelData

public protocol GetHeroesUseCaseProtocol {
    func execute(offset: Int) async throws -> CharacterDataContainer
}

public struct GetHeroes: GetHeroesUseCaseProtocol {
    private let repository: MarvelRepositoryProtocol
    
    public init(repository: MarvelRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(offset: Int) async throws -> CharacterDataContainer {
        try await repository.getHeroes(offset: offset)
    }
}
