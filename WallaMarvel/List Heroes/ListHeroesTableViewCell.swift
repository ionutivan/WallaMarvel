import Foundation
import UIKit
import Kingfisher
import MarvelData

final class ListHeroesTableViewCell: UITableViewCell, Reusable {
    enum Constants {
        static let margin: CGFloat = 12
        static let imageWidth: CGFloat = 80
    }
    
    private let heroeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // images don't seem to have all the same size
        // the following options avoid image distortion
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
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
        let imageViewHeightConstraint = heroeImageView.heightAnchor.constraint(equalToConstant: Constants.imageWidth)
        imageViewHeightConstraint.priority = .defaultHigh
        NSLayoutConstraint.activate([
            heroeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.margin),
            heroeImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.margin),
            imageViewHeightConstraint,
            heroeImageView.widthAnchor.constraint(equalToConstant: Constants.imageWidth),
            heroeImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.margin),
            
            heroeName.leadingAnchor.constraint(equalTo: heroeImageView.trailingAnchor, constant: Constants.margin),
            heroeName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.margin),
            heroeName.topAnchor.constraint(equalTo: topAnchor, constant: Constants.margin),
            // although improbable, this stops the heroe title overflow out of the cell
            heroeName.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -Constants.margin),
        ])
    }
    
    func configure(model: CharacterDataModel) {
        heroeImageView.kf.setImage(with: URL(string: model.thumbnail.path + "/portrait_small." + model.thumbnail.extension))
        heroeName.text = model.name
    }
}
