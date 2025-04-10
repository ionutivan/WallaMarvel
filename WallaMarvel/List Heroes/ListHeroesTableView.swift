import Foundation
import UIKit

final class ListHeroesView: UIView {
    enum Constant {
        static let estimatedRowHeight: CGFloat = 120
    }
    
    let spinnerView = UIActivityIndicatorView(style: .medium)
    
    let heroesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ListHeroesTableViewCell.self, forCellReuseIdentifier: ListHeroesTableViewCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Constant.estimatedRowHeight
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubviews()
        addContraints()
        spinnerView.startAnimating()
        heroesTableView.tableFooterView = spinnerView
    }
    
    private func addSubviews() {
        addSubview(heroesTableView)
    }
    
    private func addContraints() {
        NSLayoutConstraint.activate([
            heroesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            heroesTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            heroesTableView.topAnchor.constraint(equalTo: topAnchor),
            heroesTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
