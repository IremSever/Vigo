//
//  HomeViewModel.swift
//  Vigo
//
//  Created by İrem Sever on 30.01.2025.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var homeModel: HomeModel?
    
    func fetchHomeData(completion: @escaping () -> Void) {
        guard let url = URL(string: "https://api.tmgrup.com.tr/v2/link/c8b4449a37") else {
            print("invalid url")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, resume, error in
            if let error = error {
                print("error: \(error)")
                return
            }
            
            if let httpResume = resume as? HTTPURLResponse {
                print("status code: \(httpResume.statusCode)")
            }
            
            guard let data = data else {
                print("no data")
                return
            }
            
            do {
                let decodeData = try JSONDecoder().decode(HomeModel.self, from: data)
                
                DispatchQueue.main.async {
                    self.homeModel = decodeData
                    completion()
                }
            } catch {
                print("error decoding data: \(error)")
            }
        }.resume()
       
    }
}
