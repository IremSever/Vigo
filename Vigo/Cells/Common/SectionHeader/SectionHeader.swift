//
//  SectionHeader.swift
//  Vigo
//
//  Created by IREM SEVER on 13.02.2025.
//

import SwiftUI

struct SectionHeader<T: CategoryProtocol>: View, NavAnimation {
    @Binding var selectedCategory: T
    let categories: [T]
    var isExplore: Bool
    var onCategorySelected: ((T) -> Void)?
    @Binding var scrollOffset: CGFloat
    
    var body: some View {
        VStack {
            HStack {
                ForEach(categories, id: \.self) { category in
                    VStack {
                        Text(category.displayName)
                            .font(.exoBold(size: isExplore ? 14 : 14))
                            .foregroundColor(selectedCategory == category ? .white : isExplore ? .orange.opacity(0.9) : .purple)
                        
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
        }
        .background {
            if isExplore {
                BlurView(style: .systemMaterialDark)
                    .frame(height: interpolatedHeight() + 30)
                    .opacity(opacityView())
                    .ignoresSafeArea(edges: .top)
            } else {
                Color.clear
            }
        }

        .frame(maxHeight: .infinity, alignment: .top)
        .animation(.easeIn, value: scrollOffset)
    }
}
