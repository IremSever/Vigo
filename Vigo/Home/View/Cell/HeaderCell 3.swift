//
//  HeaderCell 3.swift
//  Moviex
//
//  Created by İrem Sever on 5.02.2025.
//


import SwiftUI
import SDWebImageSwiftUI

struct HeaderCell: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var pageSelected: Int = 1
    
    var body: some View {
        ZStack {
            if let homeData = viewModel.homeModel?.data, !homeData.isEmpty {
                let validData = homeData.filter { $0.news?.first?.image != nil }
                let loopingData = [validData.last!] + validData + [validData.first!]
                
                TabView(selection: $pageSelected) {
                    ForEach(loopingData.indices, id: \ .self) { index in
                        if let item = loopingData[index].news?.first {
                            NavigationLink(destination: MovieDetailsView(item: item)) {
                                ZStack {
                                    if let imageUrl = item.image, let url = URL(string: imageUrl) {
                                        GeometryReader { geo in
                                            WebImage(url: url)
                                                .resizable()
                                                .frame(width: geo.size.width, height: 600)
                                                .clipped()
                                        }
                                        .frame(height: 600)
                                    }
                                    
                                    VStack {
                                        Spacer()
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.black.opacity(0.7), Color.clear]),
                                            startPoint: .bottom,
                                            endPoint: .top
                                        )
                                        .frame(height: 250)
                                    }
                                }
                            }
                            .tag(index)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(height: 600)
                .onChange(of: pageSelected) { newIndex in
                    if newIndex == 0 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            pageSelected = loopingData.count - 2
                        }
                    } else if newIndex == loopingData.count - 1 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            pageSelected = 1
                        }
                    }
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        IndicatorCell(totalPages: validData.count, currentIndex: pageSelected - 1)
                            .padding(.bottom, 20)
                        Spacer()
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchHomeData(completion: {})
        }
    }
}
