//
//  DetailVC.swift
//  Vigo
//
//  Created by İrem Sever on 3.02.2025.
//
import SwiftUI
import SDWebImageSwiftUI
struct DetailView: View {
    @ObservedObject var viewModel: HomeViewModel
    var newsItem: News

    var body: some View {
        CustomNav(app: "chevron.left", live: "", icon: "") {
            ScrollView {
                VStack {
                    CoverCell(viewModel: viewModel, newsItem: newsItem)
                        .frame(maxWidth: .infinity)
                    
                    TrailerCell(newsItem: newsItem)
                }
            }
        }
        .background {
            Rectangle()
                .fill(.black.gradient)
                .scaleEffect(y: -1)
                .ignoresSafeArea(edges: .all)
        }
        .edgesIgnoringSafeArea(.all)
        .ignoresSafeArea(.all)
        .clearNavigationBar()
    }
}
