//
//  RowView.swift
//  Vigo
//
//  Created by IREM SEVER on 12.02.2025.
//

import SwiftUI
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
            case "cardFullImage3":
                CardCell(viewModel: viewModel, widgetTitle: viewModel.homeModel?.data[index].config.widgetTitle?.text ?? "")
      
            case "cardTopImage1":
                CardCell(viewModel: viewModel, widgetTitle: viewModel.homeModel?.data[index].config.widgetTitle?.text ?? "")
                    .padding(.bottom, 60)
            default:
                SeriesCell(viewModel: viewModel, widgetTitle: viewModel.homeModel?.data[index].config.widgetTitle?.text ?? "")
            }
        }
    }
}
