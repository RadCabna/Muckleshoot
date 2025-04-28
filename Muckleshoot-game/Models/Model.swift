//
//  Model.swift
//  Muckleshoot-game
//
//  Created by Алкександр Степанов on 27.04.2025.
//

import Foundation

struct Barier: Equatable {
    var name: String = "barier1"
    var xOffset: CGFloat = 0
    var yOffset: CGFloat = 0
    var haveBarier = true
}

struct ShopItem {
    var name: String
    var cost: Int
    var horseName: String
}


class Arrays {
    
    static var yourHorsesArray = [
    ["horseCard1","Blaze", "5", "5", "0"]
    ]
    
    static var shopItemsArray: [ShopItem] = [
        ShopItem(name: "horseCard1", cost: 300, horseName: "Blaze"),
        ShopItem(name: "horseCard2", cost: 600, horseName: "Rune"),
        ShopItem(name: "horseCard3", cost: 1000, horseName: "Zephyr"),
        ShopItem(name: "horseCard4", cost: 1500, horseName: "Ash"),
    ]
    
    static var batiersArray: [Barier] = [
    Barier(), Barier(), Barier()
    ]
}
