import Foundation
import UIKit
import MarvelData

final class ListHeroesAdapter: NSObject, UITableViewDataSource {
    var heroes: [CharacterDataModel] {
        didSet {
            Task { @MainActor [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    private let tableView: UITableView
    
    init(tableView: UITableView, heroes: [CharacterDataModel] = []) {
        self.tableView = tableView
        self.heroes = heroes
        super.init()
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListHeroesTableViewCell.reuseIdentifier, for: indexPath) as! ListHeroesTableViewCell
        
        let model = heroes[indexPath.row]
        cell.configure(model: model)
        
        return cell
    }
}
