//
//  AlbumCell.swift
//  Vigo
//
//  Created by İrem Sever on 2.02.2025.
//
import SwiftUI
import SDWebImageSwiftUI


struct AlbumCell: View {
    @ObservedObject var viewModel: HomeViewModel
    var widgetTitle: String?

    @State private var currentIndex = 1

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let widgetTitle = widgetTitle {
                Text(widgetTitle)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.horizontal)
            }

            if let homeData = viewModel.homeModel?.data {
                let filteredSections = homeData.filter { $0.config.widgetTitle?.text == widgetTitle }
                let newsItems = filteredSections.flatMap { $0.news ?? [] }

                let infiniteItems = [newsItems.last!] + newsItems + [newsItems.first!]

                TabView(selection: $currentIndex) {
                    ForEach(0..<infiniteItems.count, id: \.self) { index in
                        VStack {
                            if let imageUrl = URL(string: infiniteItems[index].image ?? "") {
                                WebImage(url: imageUrl)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 250, height: 350)
                                    .cornerRadius(12)
                            }
                            VStack(alignment: .center, spacing: 5) {
                                Text(infiniteItems[index].title)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                if let spot = infiniteItems[index].spot {
                                    Text(spot)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.center)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.7)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .tag(index)
                    }
                }
                .frame(height: 400)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .onChange(of: currentIndex) { newIndex in
                    if newIndex == 0 {
                        currentIndex = infiniteItems.count - 2
                    } else if newIndex == infiniteItems.count - 1 {
                        currentIndex = 1
                    }
                }
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}
