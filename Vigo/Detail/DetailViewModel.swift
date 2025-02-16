//
//  DetailViewModel.swift
//  Vigo
//
//  Created by İrem Sever on 17.02.2025.
//

import Foundation

class DetailViewModel: ObservableObject {
    @Published var detailModel: DetailModel?
    private var urlString: String

    init(urlString: String) {
        self.urlString = urlString
    }

    func fetchDetailData(completion: @escaping () -> Void) {
        guard let url = URL(string: urlString) else {
            print("invalid url: \(urlString)")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("error: \(error)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("status code: \(httpResponse.statusCode)")
            }
            
            guard let data = data else {
                print("no data")
                return
            }
            
            do {
                let decodeData = try JSONDecoder().decode(DetailModel.self, from: data)
                
                DispatchQueue.main.async {
                    self.detailModel = decodeData
                    completion()
                }
            } catch {
                print("error decoding data: \(error)")
            }
        }.resume()
    }
}
