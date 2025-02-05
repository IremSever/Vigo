//
//  HeaderCell 2.swift
//  Moviex
//
//  Created by İrem Sever on 2.02.2025.
//


import SwiftUI
import SDWebImageSwiftUI

struct HeaderCell: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var currentIndex: Int = 0

    var body: some View {
        if let homeData = viewModel.homeModel?.data {
            let newsList = homeData.flatMap { $0.news ?? [] }

            if newsList.isEmpty {
                Text("Haber bulunamadı")
                    .foregroundColor(.red)
            } else {
                TabView(selection: $currentIndex) {
                    ForEach(Array(newsList.enumerated()), id: \.element.title) { index, newsItem in
                        VStack {
                            if let imageUrl = URL(string: newsItem.image) {
                                WebImage(url: imageUrl)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 300)
                                    .cornerRadius(10)
                            }

                            IndicatorCell(totalPages: newsList.count, currentIndex: currentIndex)

                            VStack(alignment: .leading) {
                                Text(newsItem.title)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                if let spot = newsItem.spot {
                                    Text(spot)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding()
                        }
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .onChange(of: currentIndex) { newIndex in
                    print("Aktif index değişti: \(newIndex)")
                }
            }
        } else {
            ProgressView()
                .onAppear {
                    print("HomeViewModel yükleniyor...")
                }
        }
    }
}

struct HomeVC: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 10) {
                    HeaderCell(viewModel: viewModel)
                    if let newsList = viewModel.homeModel?.data.first?.news {
                        ForEach(newsList, id: \.title) { newsItem in
                            // SeriesCell(viewModel: viewModel)
                        }
                    } else {
                        Text("Haberler yüklenemedi")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Home")
            .onAppear {
                viewModel.fetchHomeData {
                    print("Home data fetched:", viewModel.homeModel?.data ?? "Boş veri")
                }
            }
        }
    }
}

#Preview {
    HomeVC()
}
