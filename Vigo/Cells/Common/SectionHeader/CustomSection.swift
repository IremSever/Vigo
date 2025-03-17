//
//  CustomSection.swift
//  Vigo
//
//  Created by IREM SEVER on 17.03.2025.
//

import SwiftUI

struct CustomSection: View {
    @ObservedObject var viewModel = ExploreViewModel()
    @State var scrollOffset: CGFloat = 0
    @State private var selectedCategory: CategoryType = .trending
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                ScrollOffsetBg { offset in
                    self.scrollOffset = offset - geo.safeAreaInsets.top
                }
                .frame(height: 0)

            }
            .background {
                Rectangle()
                    .fill(.black.gradient)
                    .scaleEffect(y: -1)
                    .ignoresSafeArea(edges: .all)
            }
            .safeAreaInset(edge: .top, content: {
                Color.clear.frame(height: 40)
            })
            .overlay {
                SectionHeader(
                    selectedCategory: $selectedCategory,
                    categories: CategoryType.allCases,
                    isExplore: true,
                    onCategorySelected: { selectedCategory in
                        viewModel.fetchExploreData(for: selectedCategory) {}
                    },
                    scrollOffset: $scrollOffset
                )
            }
        }
    }
}
