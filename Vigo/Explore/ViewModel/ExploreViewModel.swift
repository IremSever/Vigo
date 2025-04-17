//
//  ExploreViewModel.swift
//  Vigo
//
//  Created by IREM SEVER on 13.02.2025.
//

import SwiftUI
import Foundation

class ExploreViewModel: ObservableObject {
    @Published var exploreModel: ExploreModel?

    func fetchExploreData(for category: CategoryType, completion: @escaping () -> Void) {
        guard let url = Bundle.main.url(forResource: category.jsonFileName, withExtension: "json") else {
            print("JSON file not found: \(category.jsonFileName).json")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decodedData = try JSONDecoder().decode(ExploreModel.self, from: data)

            DispatchQueue.main.async {
                self.exploreModel = decodedData
                completion()
            }
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
}

