//
//  DatabaseModel.swift
//  CalorieCalculator
//
//  Created by Mehmet Jiyan Atalay on 25.07.2024.
//

import Foundation
import SwiftData

@Model
class DatabaseModel : Identifiable {
    var timestamp = Date()
    var name : String
    var calories : Double
    var servingSizeG: Int
    var fatTotalG: Double
    var proteinG: Double
    var carbohydratesTotalG: Double
    var sugarG: Double
    var cholesterolMg: Int
    
    init(name: String, calories: Double, servingSizeG: Int, fatTotalG: Double, proteinG: Double, carbohydratesTotalG: Double, sugarG: Double, cholesterolMg: Int) {
        self.name = name
        self.calories = calories
        self.servingSizeG = servingSizeG
        self.fatTotalG = fatTotalG
        self.proteinG = proteinG
        self.carbohydratesTotalG = carbohydratesTotalG
        self.sugarG = sugarG
        self.cholesterolMg = cholesterolMg
    }
    
    convenience init(item: Item) {
        self.init(
            name: item.name,
            calories: item.calories,
            servingSizeG: item.servingSizeG,
            fatTotalG: item.fatTotalG,
            proteinG: item.proteinG,
            carbohydratesTotalG: item.carbohydratesTotalG,
            sugarG: item.sugarG,
            cholesterolMg: item.cholesterolMg
        )
    }
}

extension DatabaseModel {
    func toItem() -> Item {
        return Item(
            name: self.name,
            calories: self.calories,
            servingSizeG: self.servingSizeG,
            fatTotalG: self.fatTotalG,
            proteinG: self.proteinG,
            cholesterolMg: self.cholesterolMg,
            carbohydratesTotalG: self.carbohydratesTotalG,
            sugarG: self.sugarG
        )
    }
}
