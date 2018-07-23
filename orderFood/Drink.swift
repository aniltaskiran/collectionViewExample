//
//  Drink.swift
//  orderFood
//
//  Created by Anıl T. on 22.07.2018.
//  Copyright © 2018 anil. All rights reserved.
//

import Foundation

struct Drink {
    var name: String?
    
    var price = ""
    var volume = ""
    
    init(dictionary: [String:Any]) {
        guard let name = dictionary["name"] as! String? else {
            return
        }
        guard let price = dictionary["price"] as! String? else {
            return
        }
        guard let volume = dictionary["volume"] as! String? else {
            return
        }
    
    self.volume = volume
    self.name = "\(name) \(volume)"
    self.price = "\(price)₺"
    }
}
