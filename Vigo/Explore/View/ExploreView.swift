//
//  ExploreVC.swift
//  Vigo
//
//  Created by İrem Sever on 5.02.2025.
//

import SwiftUI

struct ExploreView: View {
    @ObservedObject var viewModel = ExploreViewModel()
    @State private var selectedCategory: CategoryType = .trending
    @State var scrollOffset: CGFloat = 0
    var body: some View {
        NavigationView {
            ZStack {
                TrendingCell(viewModel: viewModel)
                    .frame(alignment: .center)
                    .frame(maxHeight: .infinity)
                    .ignoresSafeArea(.all)
            }
            .background {
                Rectangle()
                    .fill(.blue.gradient)
                    .scaleEffect(y: -1)
                    .ignoresSafeArea(edges: .all)
            }
            .safeAreaInset(edge: .top, content: {
                Color.clear.frame(height: 0)
            })
            .ignoresSafeArea(edges: .all)
            .onAppear {
                viewModel.fetchExploreData(for: selectedCategory) {}
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
        
    }
}

