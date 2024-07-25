//
//  CalorieCalculatorApp.swift
//  CalorieCalculator
//
//  Created by Mehmet Jiyan Atalay on 24.07.2024.
//

import SwiftUI

@main
struct CalorieCalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .modelContainer(for: DatabaseModel.self)
        }
    }
}
