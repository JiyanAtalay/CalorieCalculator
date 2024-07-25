//
//  Urls.swift
//  CalorieCalculator
//
//  Created by Mehmet Jiyan Atalay on 24.07.2024.
//

import Foundation

struct Urls {
    static func doUrl(query: String) -> URLRequest? {
        let apiKey = "?"
        let changedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let urlString = "https://api.calorieninjas.com/v1/nutrition?query=\(changedQuery!)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        
        return request
    }
}
