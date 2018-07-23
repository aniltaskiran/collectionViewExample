//
//  DrinkDetailsTableCell.swift
//  orderFood
//
//  Created by Anıl T. on 22.07.2018.
//  Copyright © 2018 anil. All rights reserved.
//

import UIKit

class DrinkDetailsTableCell: UITableViewCell {
@IBOutlet weak var drinkName: UILabel!
@IBOutlet weak var drinkPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
