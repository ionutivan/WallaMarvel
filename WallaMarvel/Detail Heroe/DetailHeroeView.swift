import Foundation
import UIKit

final class DetailHeroeView: UIView {
    let nameLabel: UILabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        addSubviews()
        addContraints()
    }
    
    private func addSubviews() {
        addSubview(nameLabel)
    }
    
    private func addContraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
