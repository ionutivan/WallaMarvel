import Foundation
import UIKit
import Kingfisher

final class ListHeroesTableViewCell: UITableViewCell, Reusable {
    private let heroeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let heroeName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubviews()
        addContraints()
    }
    
    private func addSubviews() {
        addSubview(heroeImageView)
        addSubview(heroeName)
    }
    
    private func addContraints() {
        let imageViewHeightConstraint = heroeImageView.heightAnchor.constraint(equalToConstant: 80)
        imageViewHeightConstraint.priority = .defaultHigh
        NSLayoutConstraint.activate([
            heroeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            heroeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            imageViewHeightConstraint,
            heroeImageView.widthAnchor.constraint(equalToConstant: 80),
            heroeImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            
            heroeName.leadingAnchor.constraint(equalTo: heroeImageView.trailingAnchor, constant: 12),
            heroeName.topAnchor.constraint(equalTo: heroeImageView.topAnchor, constant: 8),
        ])
    }
    
    func configure(model: CharacterDataModel) {
        heroeImageView.kf.setImage(with: URL(string: model.thumbnail.path + "/portrait_small." + model.thumbnail.extension))
        heroeName.text = model.name
    }
}
