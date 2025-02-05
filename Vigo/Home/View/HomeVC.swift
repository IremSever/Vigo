//
//  HomeVC.swift
//  Vigo
//
//  Created by İrem Sever on 31.01.2025.
//
import SwiftUI

struct HomeVC: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        if let homeData = viewModel.homeModel?.data {
                            ForEach(homeData.indices, id: \.self) { index in
                                let section = homeData[index]

                                if let widgetTitle = section.config.widgetTitle?.text {
                                    Text(widgetTitle)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                }

                                switch section.config.widget.template {
                                case "headlines":
                                    HeaderCell(viewModel: viewModel)
                                case "broadcast":
                                    StreamCell(viewModel: viewModel)
                                case "cardFullImage1":
                                    SeriesCell(viewModel: viewModel, widgetTitle: section.config.widgetTitle?.text)
                                case "cardFullImage3":
                                    AlbumCell(viewModel: viewModel)
                                case "cardTopImage1":
                                    CardCell(viewModel: viewModel)
                                default:
                                    SeriesCell(viewModel: viewModel, widgetTitle: section.config.widgetTitle?.text)
                                }
                            }
                        }
                    }
                }
                .frame(width: geometry.size.width, alignment: .leading)
                .background(Color(.black))
            }
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            viewModel.fetchHomeData{}
        }
    }
}
