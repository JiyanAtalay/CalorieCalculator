//
//  SearchViewModel\.swift
//  CalorieCalculator
//
//  Created by Mehmet Jiyan Atalay on 24.07.2024.
//

import Foundation
import Combine

class SearchViewModel : ObservableObject {
    
    private var disposeBag = Set<AnyCancellable>()
    
    @Published var foodname = ""
    
    @Published var calories = [Item]()
    
    let webservice = WebService()
    
    init() {
        self.debounceTextChanges()
    }
    
    func downloadCalories(query: String) async {
        do {
            if let urlRequest = Urls.doUrl(query: query) {
                if let data = try await webservice.downloadCalories(url: urlRequest) {
                    DispatchQueue.main.async {
                        self.calories = data.items
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func debounceTextChanges() {
        $foodname
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                Task {
                    await self.downloadCalories(query: self.foodname)
                }
            }
            .store(in: &disposeBag)
    }
}
