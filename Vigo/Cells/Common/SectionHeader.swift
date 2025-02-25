//
//  SectionHeader.swift
//  Vigo
//
//  Created by IREM SEVER on 13.02.2025.
//

import SwiftUI
//
//struct SectionHeader: View {
//    @ObservedObject var viewModel: ExploreViewModel
//    @Binding var selectedCategory: CategoryType
//    let categories: [CategoryType] = [.trending, .classics, .shows]
//
//    var body: some View {
//        HStack {
//            GeometryReader { geometry in
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack {
//                        ForEach(categories, id: \.self) { category in
//                            Text(category.displayName)
//                                .padding(.horizontal, 10)
//                                .padding(.vertical, 10)
//                                .foregroundColor(selectedCategory == category ? Color.orange : Color.white)
//                                .overlay(
//                                    Capsule()
//                                        .stroke(selectedCategory == category ? Color.orange : Color.white, lineWidth: 3)
//                                )
//                                .clipShape(Capsule())
//                                .onTapGesture {
//                                    selectedCategory = category
//                                    viewModel.fetchExploreData(for: category) {}
//                                }
//                        }
//                    }
//                    .frame(width: geometry.size.width, alignment: .center)
//                }
//            }
//        }
//    }
//}import SwiftUI
import SwiftUI

struct SectionHeader<T: CategoryProtocol>: View {
    @Binding var selectedCategory: T
    let categories: [T]
    var isExplore: Bool
    var onCategorySelected: ((T) -> Void)?

    var body: some View {
        HStack {
            ForEach(categories, id: \.self) { category in
                VStack {
                    Text(category.displayName)
                        .font(.system(size: isExplore ? 22 : 16, weight: selectedCategory == category ? .bold : .regular))
                        .foregroundColor(selectedCategory == category ? .white : isExplore ? .orange : .purple)

                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(selectedCategory == category ? .white : .clear)
                        .animation(.easeInOut, value: selectedCategory)
                        .padding(.horizontal, 12)
                }
                .padding(.horizontal, 12)
                .onTapGesture {
                    withAnimation {
                        selectedCategory = category
                        onCategorySelected?(category)
                    }
                }
            }
        }
        .padding(.top, 10)
        .background(Color(.clear))
    }
}
