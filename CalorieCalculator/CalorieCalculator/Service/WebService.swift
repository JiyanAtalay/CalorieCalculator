//
//  WebService.swift
//  CalorieCalculator
//
//  Created by Mehmet Jiyan Atalay on 24.07.2024.
//

import Foundation

class WebService {
    func downloadCalories(url: URLRequest) async throws -> CalorieModel? {
        do {
            let (data, response) = try await URLSession.shared.data(for: url)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                let calories = try JSONDecoder().decode(CalorieModel.self, from: data)
                return calories
            }
        }
        catch {
            print(error.localizedDescription)
        }
        return nil
    }
}

enum CaloriError: Error {
    case decodingError
    case networkError(Error)
}
