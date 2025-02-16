//
//  HomeVC.swift
//  Vigo
//
//  Created by İrem Sever on 31.01.2025.


//import SwiftUI
//
//struct HomeVC: View {
//    @StateObject private var viewModel = HomeViewModel()
//    @State var scrollOffsetY: CGFloat = 0
//    @State var scrollProgressX: CGFloat = 0
//
//    var body: some View {
//        NavigationView {
//            GeometryReader { geometry in
//                ScrollView {
//                    LazyVStack(alignment: .leading, spacing: 2) {
//                     
//                        
//                        if let homeData = viewModel.homeModel?.data {
//                            ForEach(homeData.indices, id: \.self) { index in
//                                if let widgetTitle = viewModel.homeModel?.data[index].config.widgetTitle?.text, !widgetTitle.isEmpty {
//                                    Text(widgetTitle)
//                                        .font(.headline)
//                                        .foregroundColor(.white)
//                                        .padding(.horizontal)
//                                }
//                                
//                                RowView(viewModel: viewModel, index: index)
//                            }
//                        }
//                    }
//                }
//                .frame(width: geometry.size.width, alignment: .leading)
//                .background {
//                    Rectangle()
//                        .fill(.black.gradient)
//                        .scaleEffect(y: -1)
//                        .ignoresSafeArea(edges: .all)
//                }
//            }
//        }
//        .onAppear {
//            viewModel.fetchHomeData{}
//        }
//    }
//}

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
        CustomNav(title: "Home", icon: "house") {
            LazyVStack(alignment: .leading) {
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
            .frame(maxWidth: .infinity)
        }
        
    }.onAppear {
            viewModel.fetchHomeData {}
        }
    }
}
