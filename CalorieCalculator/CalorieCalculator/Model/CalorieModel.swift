//
//  CalorieModel.swift
//  CalorieCalculator
//
//  Created by Mehmet Jiyan Atalay on 24.07.2024.
//

import Foundation

struct CalorieModel: Codable {
    let items: [Item]
}

// MARK: - Item
struct Item: Codable, Identifiable {
    let id = UUID()
    let name: String
    let calories: Double
    let servingSizeG: Int
    let fatTotalG, proteinG: Double
    let cholesterolMg: Int
    let carbohydratesTotalG, sugarG: Double

    enum CodingKeys: String, CodingKey {
        case name, calories
        case servingSizeG = "serving_size_g"
        case fatTotalG = "fat_total_g"
        case proteinG = "protein_g"
        case cholesterolMg = "cholesterol_mg"
        case carbohydratesTotalG = "carbohydrates_total_g"
        case sugarG = "sugar_g"
    }
}
