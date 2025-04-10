import Foundation
@preconcurrency import MarvelData
import MarvelDomain

protocol ListHeroesPresenterProtocol: AnyObject {
    var ui: ListHeroesUI? { get set }
    func screenTitle() -> String
    func getHeroes() async
}

protocol ListHeroesUI: AnyObject {
    func update(heroes: Result<[CharacterDataModel], Error>)
    var spinnerVisibility: Bool { get set }
}

final class ListHeroesPresenter: ListHeroesPresenterProtocol {
    enum Constants {
        static let limit = 20
    }

    var ui: ListHeroesUI?
    private let getHeroesUseCase: GetHeroesUseCaseProtocol

    private var offset = 0
    private var isLoading = false
    private var allHeroesLoaded = false

    init(getHeroesUseCase: GetHeroesUseCaseProtocol) {
        self.getHeroesUseCase = getHeroesUseCase
    }

    func screenTitle() -> String {
        "List of Heroes"
    }

    // MARK: UseCases

    func getHeroes() async {
        guard !isLoading, !allHeroesLoaded else { return }
        isLoading = true
        DispatchQueue.main.async { [weak self] in
            self?.ui?.spinnerVisibility = true
        }
        do {
            let characterDataContainer = try await getHeroesUseCase.execute(offset: offset)
            #if DEBUG
                print("Characters \(characterDataContainer.characters)")
            #endif
            DispatchQueue.main.async { [weak self] in
                self?.ui?.update(heroes: .success(characterDataContainer.characters))
                self?.ui?.spinnerVisibility = false
            }
            offset += characterDataContainer.characters.count
            allHeroesLoaded = characterDataContainer.characters.count < Constants.limit
            isLoading = false
        } catch {
            DispatchQueue.main.async { [weak self] in
                self?.ui?.update(heroes: .failure(error))
                self?.ui?.spinnerVisibility = false
            }
        }

    }
}
