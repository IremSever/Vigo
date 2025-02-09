//
//  DetailVC.swift
//  Vigo
//
//  Created by İrem Sever on 3.02.2025.
//
import SwiftUI
import SDWebImageSwiftUI

struct DetailVC: View {
    @ObservedObject var viewModel: HomeViewModel
    var selectedIndex: Int
    var widgetTitle: String

    var body: some View {
        VStack {
            if let homeData = viewModel.homeModel?.data, !homeData.isEmpty {
             
                let filteredSections = homeData.filter { $0.config.widgetTitle?.text == widgetTitle }
                let newsItems = filteredSections.flatMap { $0.news ?? [] }

                if selectedIndex < newsItems.count {
                    let item = newsItems[selectedIndex]
                    Text(item.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()

                    if let imageUrl = item.image, let url = URL(string: imageUrl) {
                        WebImage(url: url)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 300)
                            .cornerRadius(20)
                            .padding()
                    }

                    if let spot = item.spot {
                        Text(spot)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding()
                    }
                } else {
                    Text("Invalid index")
                        .font(.title)
                        .padding()
                }
            } else {
                Text("Loading Data...")
                    .font(.title)
                    .padding()
            }

            Spacer()
        }
        .navigationTitle("Detail View")
        .onAppear {
            viewModel.fetchHomeData {
                // Veriler yüklendiğinde yapılacak işlemler
            }
        }
    }
}
