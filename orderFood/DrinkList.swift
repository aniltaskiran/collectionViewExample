//
//  DrinkList.swift
//  orderFood
//
//  Created by Anıl T. on 22.07.2018.
//  Copyright © 2018 anil. All rights reserved.
//

import Foundation

struct DrinkList {
    var drinks: [Drink] = []
    var category: (firstLine: String?,secondLine: String?)

    
    init(dictionary: [String:Any]) {
        guard let drinksList = dictionary["drinks"] as? [Any] else { return }
        
        var subCategory = dictionary["cat"] as? String
        subCategory = categoryToName[subCategory!]
        
        let subStrings = subCategory?.split(separator: " ")
        if let firstLine = (subStrings?.first) {
            category.firstLine = String(firstLine)
        }
        if let secondLine = (subStrings?.last) {
            category.secondLine = String(secondLine)
        }
        
        if category.secondLine == category.firstLine {
            category.secondLine = category.firstLine
            category.firstLine = ""
        }
        
        for drink in drinksList {
            guard let drinkDic = drink as? [String:Any] else { return }
            drinks.append(Drink(dictionary: drinkDic))
        }
        
    }
}
