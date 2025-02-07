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
                    VStack(alignment: .leading, spacing: 2) {
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
                                    DynamicCell(viewModel: viewModel)
                                case "broadcast":
                                    StreamCell(viewModel: viewModel)
                                case "cardFullImage1":
                                    SeriesCell(viewModel: viewModel, widgetTitle: section.config.widgetTitle?.text)
                                case "cardFullImage3":
                                    CardCell(viewModel: viewModel)
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
struct DynamicCell: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        ZStack {
            if let homeData = viewModel.homeModel?.data {
                // If data count is 4 or fewer, show HeaderCell
                if homeData.count <= 4 {
                    HeaderCell(viewModel: viewModel)
                }
                // If data count is greater than 4, show AlbumCell
                else {
                    AlbumCell(viewModel: viewModel)
                }
            }
        }
        .onAppear {
            viewModel.fetchHomeData(completion: {})
        }
    }
}
