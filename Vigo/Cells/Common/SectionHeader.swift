//
//  SectionHeader.swift
//  Vigo
//
//  Created by IREM SEVER on 13.02.2025.
//

import SwiftUI
import SwiftUI

struct SectionHeader: View {
    @ObservedObject var viewModel: ExploreViewModel
    @Binding var selectedCategory: CategoryType
    let categories: [CategoryType] = [.trending, .classics, .shows]

    var body: some View {
        HStack {
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(categories, id: \.self) { category in
                            Text(category.displayName)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 10)
                                .foregroundColor(selectedCategory == category ? Color.orange : Color.white)
                                .overlay(
                                    Capsule()
                                        .stroke(selectedCategory == category ? Color.orange : Color.white, lineWidth: 3)
                                )
                                .clipShape(Capsule())
                                .onTapGesture {
                                    selectedCategory = category
                                    viewModel.fetchExploreData(for: category) {}
                                }
                        }
                    }
                    .frame(width: geometry.size.width, alignment: .center)
                }
            }
        }
    }
}
