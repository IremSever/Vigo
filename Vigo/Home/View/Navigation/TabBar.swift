//
//  TabBar.swift
//  Vigo
//
//  Created by İrem Sever on 5.02.2025.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case home
    case explore
    case favorites
}
struct TabBar: View {
    @Binding var selectedTab: Tab

    var body: some View {
        HStack {
            tabButton(for: .home, imageName: "house.fill")
            tabButton(for: .explore, imageName: "magnifyingglass")
            tabButton(for: .favorites, imageName: "heart.fill")
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 15)
        .background(Color.black)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.white.opacity(0.5), radius: 5, x: 0, y: 0)
        .padding(.horizontal, 40)
        .padding(.vertical, 30)
        .opacity(1)
    }

    func tabButton(for tab: Tab, imageName: String) -> some View {
        Button(action: {
            withAnimation { selectedTab = tab }
        }) {
            SwiftUI.Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .opacity(selectedTab == tab ? 1 : 0.5)
        }
    }
}
