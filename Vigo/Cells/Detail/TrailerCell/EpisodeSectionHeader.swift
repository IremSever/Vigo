//
//  EpisodeSectionHeader.swift
//  Vigo
//
//  Created by İrem Sever on 24.02.2025.
//
import SwiftUI
import SDWebImageSwiftUI

struct EpisodeSectionHeader: View {
    @Binding var selectedTab: String
    let tabs: [String]

    var body: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                VStack {
                    Text(tab)
                        .font(.system(size: 16, weight: selectedTab == tab ? .bold : .regular))
                        .foregroundColor(selectedTab == tab ? .white : .purple)
                
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(selectedTab == tab ? .white : .clear)
                        .animation(.easeInOut, value: selectedTab)
                        .padding(.horizontal, 12)
                }
                .padding(.horizontal, 10)
                .onTapGesture {
                    withAnimation {
                        selectedTab = tab
                    }
                }
            }
        }
        .padding(.top, 10)
        .background(Color(.clear))
    }
}
