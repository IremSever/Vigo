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
    var body: some View {
        NavigationView {
            ZStack {
                TrendingCell(viewModel: viewModel)
                    .frame(alignment: .center)
                    .frame(maxHeight: .infinity)
                    .ignoresSafeArea(.all)
            }
      
            .onAppear {
                viewModel.fetchExploreData(for: selectedCategory) {}
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

