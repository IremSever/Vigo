//
//  HomeViewModel.swift
//  Vigo
//
//  Created by İrem Sever on 30.01.2025.
//
//
//import Foundation
//import SwiftUI
//
//class HomeViewModel: ObservableObject {
//    @Published var homeModel: HomeModel?
//    @Published var widgetTitle: String = "" 
//    func fetchHomeData(completion: @escaping () -> Void) {
//        guard let url = URL(string: "https://api.tmgrup.com.tr/v2/link/c8b4449a37") else {
//            print("invalid url")
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url) { data, resume, error in
//            if let error = error {
//                print("error: \(error)")
//                return
//            }
//            
//            if let httpResume = resume as? HTTPURLResponse {
//                print("status code: \(httpResume.statusCode)")
//            }
//            
//            guard let data = data else {
//                print("no data")
//                return
//            }
//            
//            do {
//                let decodeData = try JSONDecoder().decode(HomeModel.self, from: data)
//                
//                DispatchQueue.main.async {
//                    self.homeModel = decodeData
//                    completion()
//                }
//            } catch {
//                print("error decoding data: \(error)")
//            }
//        }.resume()
//       
//    }
//}
//extension HomeViewModel {
//    func getBackdropImages() -> [String] {
//        guard let homeData = homeModel?.data else { return [] }
//        return homeData.flatMap { $0.news?.compactMap { $0.image } ?? [] }
//    }
//}
import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var homeModel: HomeModel?
    @Published var widgetTitle: String = ""

    func fetchHomeData(completion: @escaping () -> Void) {
        guard let url = Bundle.main.url(forResource: "home", withExtension: "json") else {
            print("Invalid URL for home.json")
            return
        }
        
        do {
            let data = try Data(contentsOf: url) // Yerel dosyayı yükle
            let decodeData = try JSONDecoder().decode(HomeModel.self, from: data)
            
            DispatchQueue.main.async {
                self.homeModel = decodeData
                completion()
            }
        } catch {
            print("Error loading or decoding data: \(error)")
        }
    }
}

extension HomeViewModel {
    func getBackdropImages() -> [String] {
        guard let homeData = homeModel?.data else { return [] }
        return homeData.flatMap { $0.news?.compactMap { $0.image } ?? [] }
    }
}
