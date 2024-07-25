//
//  ContentView.swift
//  CalorieCalculator
//
//  Created by Mehmet Jiyan Atalay on 24.07.2024.
//

import SwiftUI
import SwiftData

struct SearchView: View {
    
    @ObservedObject var viewmodel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            
            TextField("Food name", text: $viewmodel.foodname)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Divider().padding(.horizontal)
            
            List(viewmodel.calories) { item in
                NavigationLink {
                    DetailsView(item: item)
                } label: {
                    HStack {
                        Text(item.name)
                        Spacer()
                        Text("\(String(format: "%.2f", item.calories)) cal")
                        
                    }
                }
            }
        }
    }
}

#Preview {
    SearchView()
        .modelContainer(for: DatabaseModel.self)
}
