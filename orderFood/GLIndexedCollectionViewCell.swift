//
//  GLIndexedCollectionViewCell.swift
//  GLTableCollectionView
//
//  Created by Giulio Lombardo on 24/11/16.
//

import UIKit

class GLIndexedCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "collectionViewCellID"

    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var drinkNameFirstLineLabel: UILabel!
    @IBOutlet weak var drinkNameSecondLineLabel: UILabel!

    func setDrinkNameLabel(name: String) {
        var _ = (firstLine: "", secondLine: "")

        let subStrings = name.split(separator: " ")

        if subStrings.first == subStrings.last {
            drinkNameFirstLineLabel.text = ""
            drinkNameFirstLineLabel.backgroundColor = .clear
            drinkNameSecondLineLabel.text = String(subStrings.first!)
        } else {
            drinkNameFirstLineLabel.backgroundColor = drinkNameSecondLineLabel.backgroundColor
            drinkNameFirstLineLabel.text = String(subStrings.first!)
            drinkNameSecondLineLabel.text = String(subStrings.last!)
        }

    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
