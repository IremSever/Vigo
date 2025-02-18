//
//  ExploreViewModel.swift
//  Vigo
//
//  Created by IREM SEVER on 13.02.2025.
//

import SwiftUI
import Foundation
//
//class ExploreViewModel: ObservableObject {
//    @Published var exploreModel: ExploreModel?
//
//    func fetchExploreData(for category: CategoryType, completion: @escaping () -> Void) {
//        let urlString = category.url
//
//        guard let url = URL(string: urlString) else {
//            print("Invalid URL")
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            if let error = error {
//                print("Error: \(error)")
//                return
//            }
//
//            guard let data = data else {
//                print("No data received")
//                return
//            }
//
//            do {
//                let decodeData = try JSONDecoder().decode(ExploreModel.self, from: data)
//
//                DispatchQueue.main.async {
//                    self.exploreModel = decodeData
//                    completion()
//                }
//            } catch {
//                print("Error decoding data: \(error)")
//            }
//        }.resume()
//    }
//}
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

