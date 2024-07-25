//
//  ListView.swift
//  CalorieCalculator
//
//  Created by Mehmet Jiyan Atalay on 25.07.2024.
//

import SwiftUI
import SwiftData

struct ListView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \DatabaseModel.timestamp, order: .reverse) private var datas : [DatabaseModel]
    
    
    var body: some View {
        NavigationStack {
            List(datas) { data in
                NavigationLink {
                    DetailsView(item: data.toItem())
                } label: {
                    HStack {
                        Text(data.name)
                        Spacer()
                        Text("\(String(format: "%.2f", data.calories)) cal")
                        
                    }
                }
            }
            .navigationTitle("Favorites")
            .toolbarTitleDisplayMode(.inlineLarge)
        }
    }
}

#Preview {
    ListView()
        .modelContainer(for: DatabaseModel.self)
}
