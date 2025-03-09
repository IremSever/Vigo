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
                    SectionHeader(selectedCategory: $selectedCategory,
                                  categories: CategoryType.allCases,
                                  isExplore: true,
                                  onCategorySelected: { selectedCategory in
                        viewModel.fetchExploreData(for: selectedCategory) {}
                    })
                    .padding(.top, 10)
                    Spacer()
                }
                
            }
            .onAppear {
                viewModel.fetchExploreData(for: selectedCategory) {}
            }
            .background(Color.black)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}
