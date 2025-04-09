import UIKit
import MarvelData
import MarvelDomain

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let getHeroesUseCase = GetHeroes(repository: MarvelRepository(dataSource: MarvelDataSource(apiClient: APIClient(urlSession: .shared))))
        let presenter = ListHeroesPresenter(getHeroesUseCase: getHeroesUseCase)
        let listHeroesViewController = ListHeroesViewController()
        listHeroesViewController.presenter = presenter
        
        let navigationController = UINavigationController(rootViewController: listHeroesViewController)
        window.rootViewController = navigationController
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}

