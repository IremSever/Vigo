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
                    .ignoresSafeArea(edges: .all)
                    .frame(maxHeight: .infinity, alignment: .center)
                    .background(Color.black)
                
                VStack {
                    SectionHeader(viewModel: viewModel, selectedCategory: $selectedCategory)
                        .padding(.top, 10)
                        .background(Color.clear)
                }
            }
            .onAppear {
                viewModel.fetchExploreData(for: selectedCategory) {}
            }
            .background(.black)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}
