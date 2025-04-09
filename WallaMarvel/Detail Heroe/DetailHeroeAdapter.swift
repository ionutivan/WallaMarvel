import Foundation
import UIKit

final class DetailHeroeAdapter {
    var heroe: CharacterDataModel? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.nameLabel.text = self?.heroe?.name
            }
        }
    }

    private let nameLabel: UILabel

    init(nameLabel: UILabel, heroe: CharacterDataModel?) {
        self.nameLabel = nameLabel
        self.heroe = heroe
    }
}
