import UIKit

final class DetailHeroeViewController: UIViewController {
    var mainView: DetailHeroeView { return view as! DetailHeroeView  }
    
    var presenter: DetailHeroePresenterProtocol?
    var detailsHeroProvider: DetailHeroeAdapter?
    
    override func loadView() {
        view = DetailHeroeView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        detailsHeroProvider = DetailHeroeAdapter(nameLabel: mainView.nameLabel, heroe: nil)
        Task { [weak self] in
            await self?.presenter?.getHeroe()
        }
        presenter?.ui = self
        
        title = presenter?.screenTitle()
    }
}

extension DetailHeroeViewController: DetailHeroeUI {
    func update(heroe: Result<CharacterDataModel, Error>) {
        switch heroe {
            case let .success(character):
                detailsHeroProvider?.heroe = character
            case .failure:
                let alert = UIAlertController(title: "Error",
                                                message: "An unknown error occurred",
                                                preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
        }
    }
}

