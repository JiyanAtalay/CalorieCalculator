//
//  DetailsView.swift
//  CalorieCalculator
//
//  Created by Mehmet Jiyan Atalay on 24.07.2024.
//

import SwiftUI
import SwiftData

struct DetailsView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var datas : [DatabaseModel]
    
    var item : Item
    
    @State private var statusBool : Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Serving size:")
                    Spacer()
                    Text("\(item.servingSizeG)g")
                }.padding(.vertical, 8)
                HStack {
                    Text("Total Calories:")
                    Spacer()
                    Text("\(String(format: "%.2f", item.calories)) kcal")
                }.padding(.vertical, 8)
                HStack {
                    Text("Total Fat:")
                    Spacer()
                    Text("\(String(format: "%.2f", item.fatTotalG)) g")
                }.padding(.vertical, 8)
                HStack {
                    Text("Total Protein:")
                    Spacer()
                    Text("\(String(format: "%.2f", item.proteinG)) g")
                }.padding(.vertical, 8)
                HStack {
                    Text("Total Cholesterol:")
                    Spacer()
                    Text("\(item.cholesterolMg) mg")
                }.padding(.vertical, 8)
                HStack {
                    Text("Total Carbohydrates:")
                    Spacer()
                    Text("\(String(format: "%.2f", item.carbohydratesTotalG)) g")
                }.padding(.vertical, 8)
                HStack {
                    Text("Total Sugar:")
                    Spacer()
                    Text("\(String(format: "%.2f", item.sugarG)) g")
                }.padding(.vertical, 8)
            }
            .padding()
        }
        .task {
            searchFood(name: item.name)
        }
        .navigationTitle(item.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    checkFood(name: item.name)
                }, label: {
                    Image(systemName: statusBool ? "star.fill" : "star") // star.fill
                })
            }
        }
    }
    
    private func searchFood(name: String) {
        let descriptor = FetchDescriptor<DatabaseModel>(
            predicate: #Predicate { $0.name == name }
        )
        do {
            let elements = try modelContext.fetch(descriptor)
            
            statusBool = !elements.isEmpty
        } catch {
            print("Fetch error: \(error.localizedDescription)")
        }
    }
    
    func checkFood(name: String) {
        if statusBool {
            
            let fetchRequest = FetchDescriptor<DatabaseModel>(
                predicate: #Predicate { $0.name == name }
            )
            
            do {
                let results = try modelContext.fetch(fetchRequest)
                if let objectToDelete = results.first {
                    withAnimation {
                        modelContext.delete(objectToDelete)
                    }
                } else {
                    print("Nesne bulunamadı.")
                }
                statusBool = false
            } catch {
                print("Fetch error: \(error)")
            }
        } else {
            let newObject = DatabaseModel(item: item)
            modelContext.insert(newObject)
            statusBool = true
        }
        
        do {
            try modelContext.save()
        } catch {
            print(error.localizedDescription)
        }
        
    }
}

#Preview {
    DetailsView(item: Item(name: "kebab", calories: 110.6, servingSizeG: 100, fatTotalG: 1.1, proteinG: 7.4, cholesterolMg: 18, carbohydratesTotalG: 17.4, sugarG: 13.1))
        .modelContainer(for: DatabaseModel.self)
}
