//
//  HeaderCell 2.swift
//  Moviex
//
//  Created by İrem Sever on 3.02.2025.
//


import SwiftUI
import SDWebImageSwiftUI

struct HeaderCell: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var pageSelected: Int = 0
    
    var body: some View {
        ZStack {
            if let homeData = viewModel.homeModel?.data, !homeData.isEmpty {
                let validData = homeData.filter { $0.news?.first?.image != nil }
                
                TabView(selection: $pageSelected) {
                    ForEach(validData.indices, id: \.self) { index in
                        VStack {
                            if let imageUrl = validData[index].news?.first?.image, let url = URL(string: imageUrl) {
                                WebImage(url: url)
                                    .resizable()
                                    .scaledToFill()  // Görselleri doldurur
                                    .frame(width: UIScreen.main.bounds.width, height: 300)  // Sabit yükseklik (300px)
                                    .clipped()  // Görselin taşmasını engeller
                                    .tag(index)
                            }

                            VStack(alignment: .leading) {
                                if let title = validData[index].news?.first?.title {
                                    Text(title)
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding(.leading, 8)
                                }
                                
                                if let spot = validData[index].news?.first?.spot {
                                    Text(spot)
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .padding(.leading, 8)
                                }
                            }
                            .padding(.top, 8)
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(height: 300)  // TabView yüksekliğini de sabitledik
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        IndicatorCell(totalPages: validData.count, currentIndex: pageSelected)
                            .padding(.bottom, 50)
                        Spacer()
                    }
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
            viewModel.fetchHomeData(completion: {})
        }
    }
}
