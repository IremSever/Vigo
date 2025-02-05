//
//  HeaderCell.swift
//  Vigo
//
//  Created by İrem Sever on 2.02.2025.
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
                
                var loopingData: [HomeData] {
                    guard let first = validData.first, let last = validData.last else { return validData }
                    return [last] + validData + [first]
                }

                TabView(selection: $pageSelected) {
                    ForEach(loopingData.indices, id: \.self) { index in
                        let item = loopingData[index]
                        let imageUrl = item.news?.first?.image ?? ""
                        let url = URL(string: imageUrl)

                        ZStack {
                            if let url = url {
                                WebImage(url: url)
                                    .resizable()
                                    .frame(height: 600)
                            }
                        }
                        .tag(index)
                        .overlay(
                            NavigationLink(
                                destination: DetailVC(
                                    viewModel: viewModel,
                                    selectedIndex: (index == 0) ? validData.count - 1 :
                                                   (index == loopingData.count - 1) ? 0 : index - 1
                                )
                            ) {
                                Color.black
                            }
                        )

                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(height: 600)
                
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
