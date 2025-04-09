import Foundation

protocol DetailHeroePresenterProtocol: AnyObject {
    var ui: DetailHeroeUI? { get set }
    func screenTitle() -> String
    func getHeroe() async
}

protocol DetailHeroeUI: AnyObject {
    func update(heroe: Result<CharacterDataModel, Error>)
}

final class DetailHeroePresenter: DetailHeroePresenterProtocol {
    var ui: DetailHeroeUI?
    private let getHeroeUseCase: GetHeroeDetailsUseCaseProtocol
    
    init(getHeroeUseCase: GetHeroeDetailsUseCaseProtocol) {
        self.getHeroeUseCase = getHeroeUseCase
    }
    
    func screenTitle() -> String {
        "Heroe Detail"
    }
    
    // MARK: UseCases
    
    func getHeroe() async {
        do {
            let character = try await getHeroeUseCase.execute()
            #if DEBUG
                print("Character \(character)")
            #endif
            ui?.update(heroe: .success(character))
        } catch {
            ui?.update(heroe: .failure(error))
        }
        
    }
}

