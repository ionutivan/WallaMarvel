import Foundation
import MarvelData 

public protocol GetHeroeDetailsUseCaseProtocol {
    func execute() async throws -> CharacterDataModel
}

public struct GetHeroeDetails: GetHeroeDetailsUseCaseProtocol {
    private let repository: MarvelRepositoryProtocol
    private let heroeID: Int
    
    public init(heroeID: Int, repository: MarvelRepositoryProtocol) {
        self.repository = repository
        self.heroeID = heroeID
    }
    
    public func execute() async throws -> CharacterDataModel {
        try await repository.getHeroeDetail(heroeID: heroeID)
    }
}
