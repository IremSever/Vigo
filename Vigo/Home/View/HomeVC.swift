//
//  HomeVC.swift
//  Vigo
//
//  Created by İrem Sever on 31.01.2025.
import SwiftUI

struct HomeVC: View {
    @StateObject private var viewModel = HomeViewModel()
    @State var scrollOffsetY: CGFloat = 0
    @State var scrollProgressX: CGFloat = 0

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 2) {
                        InfoTop()
                            .zIndex(1)
                        
                        if let homeData = viewModel.homeModel?.data {
                            ForEach(homeData.indices, id: \.self) { index in
                                if let widgetTitle = viewModel.homeModel?.data[index].config.widgetTitle?.text, !widgetTitle.isEmpty {
                                    Text(widgetTitle)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                }
                                
                                RowView(viewModel: viewModel, index: index)
                            }
                        }
                    }
                }
                .frame(width: geometry.size.width, alignment: .leading)
                .background {
                    Rectangle()
                        .fill(.black.gradient)
                        .scaleEffect(y: -1)
                        .ignoresSafeArea(edges: .all)
                }
            }
        }
        .onAppear {
            viewModel.fetchHomeData{}
        }
    }
}

struct RowView: View {
    let viewModel: HomeViewModel
    let index: Int

    var body: some View {
        if let template = viewModel.homeModel?.data[index].config.widget.template {
            switch template {
            case "headlines":
                let newsItems = viewModel.homeModel?.data[index].news ?? []
                
                let externalNewsItems = newsItems.filter { newsItem in
                    newsItem.external.starts(with: "external://https:")
                }
                let videoNewsItems = newsItems.filter { newsItem in
                    newsItem.external.starts(with: "video://")
                }
                if !externalNewsItems.isEmpty {
                    AchiveCell(viewModel: viewModel)
                } else if !videoNewsItems.isEmpty {
                    AlbumCell(viewModel: viewModel)
                } else {
                    Text("No news available")
                        .foregroundColor(.white)
                }
            case "broadcast":
                StreamCell(viewModel: viewModel)

            case "cardFullImage1":
                SeriesCell(viewModel: viewModel, widgetTitle: viewModel.homeModel?.data[index].config.widgetTitle?.text ?? "")

            case "cardFullImage3", "cardTopImage1":
                CardCell(viewModel: viewModel, widgetTitle: viewModel.homeModel?.data[index].config.widgetTitle?.text ?? "")

            default:
                SeriesCell(viewModel: viewModel, widgetTitle: viewModel.homeModel?.data[index].config.widgetTitle?.text ?? "")
            }
        }
    }
}
