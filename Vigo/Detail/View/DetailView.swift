//
//  DetailVC.swift
//  Vigo
//
//  Created by İrem Sever on 3.02.2025.
//
import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let detailModel = viewModel.detailModel {
                    
                    if let firstData = detailModel.data.first {
                        
     
                        if let imageUrlString = firstData.singleImage?.src, let imageUrl = URL(string: imageUrlString) {
                            AsyncImage(url: imageUrl) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(maxWidth: .infinity, maxHeight: 500)
                        }
                        if let description = firstData.detailDescription?.description {
                            Text(description)
                                .font(.body)
                                .foregroundColor(.gray)
                                
                                .padding()
                        }
                    }
                }
            }
        }.padding()
    }
}


