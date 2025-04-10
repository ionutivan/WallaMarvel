import UIKit
import MarvelData
import MarvelDomain

final class ListHeroesViewController: UIViewController {
    var mainView: ListHeroesView { return view as! ListHeroesView  }
    
    var presenter: ListHeroesPresenterProtocol?
    var listHeroesProvider: ListHeroesAdapter?
    
    override func loadView() {
        view = ListHeroesView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        listHeroesProvider = ListHeroesAdapter(tableView: mainView.heroesTableView)
        Task { [weak self] in
            await self?.presenter?.getHeroes()
        }
        presenter?.ui = self
        
        title = presenter?.screenTitle()
        
        mainView.heroesTableView.delegate = self
    }
}

extension ListHeroesViewController: ListHeroesUI {
    func update(heroes: Result<[CharacterDataModel], Error>) {
        switch heroes {
            case let .success(characters):
                listHeroesProvider?.heroes.append(contentsOf: characters)
            case .failure:
                let alert = UIAlertController(title: "Error",
                                              message: "An unknown error occurred",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
        }
    }
}

extension ListHeroesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let selectedHero = listHeroesProvider?.heroes[indexPath.row] else {
            return
        }
        let getHeroeUseCase = GetHeroeDetails(heroeID: selectedHero.id, repository: MarvelRepository(dataSource: MarvelDataSource(apiClient: APIClient(urlSession: URLSession.shared))))
        let presenter = DetailHeroePresenter(getHeroeUseCase: getHeroeUseCase)
        let detailHeroeViewController = DetailHeroeViewController()
        detailHeroeViewController.presenter = presenter
        
        navigationController?.pushViewController(detailHeroeViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let heroes = listHeroesProvider?.heroes else {
            return
        }
        if indexPath.row == heroes.count - 1 {
            Task { [weak self] in
                await self?.presenter?.getHeroes()
            }
        }
    }
}

