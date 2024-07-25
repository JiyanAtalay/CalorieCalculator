//
//  MainView.swift
//  CalorieCalculator
//
//  Created by Mehmet Jiyan Atalay on 25.07.2024.
//

import SwiftUI
import SwiftData

struct MainView: View {
    var body: some View {
        TabView {
            ListView()
                .tabItem {
                    Label("List", systemImage: "list.dash")
                }
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
}

#Preview {
    MainView()
        .modelContainer(for: DatabaseModel.self)
}
