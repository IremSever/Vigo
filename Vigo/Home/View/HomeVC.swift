//
//  HomeVC.swift
//  Vigo
//
//  Created by İrem Sever on 31.01.2025.
//
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
                                let section = homeData[index]

                                if let widgetTitle = section.config.widgetTitle?.text {
                                    Text(widgetTitle)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                }

                                switch section.config.widget.template {
                                case "headlines":
                                    AlbumCell(viewModel: viewModel, widgetTitle: section.config.widgetTitle?.text ?? "")

                                case "broadcast":
                                    StreamCell(viewModel: viewModel)
                                case "cardFullImage1":
                                    SeriesCell(viewModel: viewModel, widgetTitle: section.config.widgetTitle?.text ?? "")
                                case "cardFullImage3":
                                    CardCell(viewModel: viewModel, widgetTitle: section.config.widgetTitle?.text ?? "")
                                case "cardTopImage1":
                                    CardCell(viewModel: viewModel, widgetTitle: section.config.widgetTitle?.text ?? "")
                                        .padding(.bottom, 50)
                                default:
                                    SeriesCell(viewModel: viewModel, widgetTitle: section.config.widgetTitle?.text ?? "")
                                        
                                }
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
struct DynamicCell: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        Group {
            if let homeData = viewModel.homeModel?.data {
                let newsItems = homeData.flatMap { $0.news ?? [] }

                switch (newsItems.first(where: { $0.external.starts(with: "video://") }), newsItems.first(where: { $0.external.starts(with: "external://https:") })) {
                case (nil, let nonVideoItem?):
                    AchiveCell(viewModel: viewModel)
                        .zIndex(-1)
                case (let videoItem?, _):
                    AlbumCell(viewModel: viewModel)
                        .zIndex(-1)
                
                default:
                    EmptyView() // veya başka bir default view
                }
            }
        }
        .onAppear()
    }
}
