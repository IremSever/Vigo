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
                            .font(.exoBold(size: isExplore ? 20 : 16))
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
 
           
        }
        .background(
            Color.black.opacity(opacityView())
                .frame(maxWidth: .infinity)
                .frame(height: interpolatedHeight() + 50)
                .blur(radius: 20)
                .clipped()
                .ignoresSafeArea(.all)
        )
        .frame(maxHeight: .infinity, alignment: .top)
        .animation(.easeIn, value: scrollOffset)
    }
}
