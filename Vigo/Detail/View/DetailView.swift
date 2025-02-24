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
    var buttonName: String = "chevron.left"

    var body: some View {
        CustomNav(app: buttonName, live: "", icon: "") {
            LazyVStack {
                CoverCell(viewModel: viewModel, newsItem: newsItem)
                TrailerCell(newsItem: newsItem)
            }
            
        }
        .navigationBarHidden(true)
    }
}
