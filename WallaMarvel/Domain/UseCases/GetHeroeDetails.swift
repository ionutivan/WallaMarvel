import Foundation

protocol GetHeroeDetailsUseCaseProtocol {
    func execute() async throws -> CharacterDataModel
}

struct GetHeroeDetails: GetHeroeDetailsUseCaseProtocol {
    private let repository: MarvelRepositoryProtocol
    private let heroeID: Int
    
    init(heroeID: Int, repository: MarvelRepositoryProtocol = MarvelRepository()) {
        self.repository = repository
        self.heroeID = heroeID
    }
    
    func execute() async throws -> CharacterDataModel {
        try await repository.getHeroeDetail(heroeID: heroeID)
    }
}
