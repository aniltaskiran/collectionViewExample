//
//  DummyData.swift
//  orderFood
//
//  Created by Anıl T. on 22.07.2018.
//  Copyright © 2018 anil. All rights reserved.
//

import Foundation
let dummyAllCategories = ["barrelBeer", "beer", "wine", "Coctely", "Coke", "Hot"]
let barrelBeers = [["name": "Efes ", "volume": "70cl", "price": "15"],
                   ["name": "Efes ", "volume": "50cl", "price": "12"],
                   ["name": "Efes ", "volume": "33cl", "price": "11"],
                   ["name": "Bomonti ", "volume": "70cl", "price": "15"],
                   ["name": "Bomonti ", "volume": "50cl", "price": "12"],
                   ["name": "Bomonti ", "volume": "33cl", "price": "11"],
                   ["name": "Beck’s ", "volume": "70cl", "price": "15"],
                   ["name": "Beck’s ", "volume": "50cl", "price": "12"],
                   ["name": "Beck’s ", "volume": "33cl", "price": "11"]]

let bottleBeers = [
    ["name": "Bomonti Filtresiz ", "volume": "50cl", "price": "14"],
    ["name": "Efes Özel Seri ", "volume": "50cl", "price": "14"],
    ["name": "Efes Malt ", "volume": "50cl", "price": "14"],
    ["name": "Efes Pastörsüz", "volume": "50cl", "price": "14"],
    ["name": "Bomonti Red ", "volume": "50cl", "price": "14"],
    ["name": "Amsterdam ", "volume": "50cl", "price": "19"],
    ["name": "Grolsch ", "volume": "45cl", "price": "19"],
    ["name": "Duvel ", "volume": "33cl", "price": "19"],
    ["name": "Erdinger ", "volume": "33cl", "price": "18"],
    ["name": "Efes ", "volume": "33cl", "price": "12"],
    ["name": "Beck’s ", "volume": "33cl", "price": "12"],
    ["name": "Bomonti ", "volume": "33cl", "price": "12"],
    ["name": "Miller ", "volume": "33cl", "price": "12"]]

let bottleDrinks: [String: Any] = ["drinks": bottleBeers, "cat": "bottles"]
let barrelDrinks: [String: Any]  = ["drinks": barrelBeers, "cat": "barrels"]

let categories = ["barrels", "bottles", "whiskeys", "wine", "coctely", "coke", "hot"]

let categoryToName = ["barrels": "Fıçı Biralar", "bottles": "Şişe Biralar", "whiskeys": "Viskiler", "wine": "Şaraplar", "coctely": "Kokteyler", "coke": "Soğuk İçecekler", "hot": "Sıcak İçecekler"]
