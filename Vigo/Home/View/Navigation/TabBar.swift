//
//  TabBar.swift
//  Vigo
//
//  Created by İrem Sever on 5.02.2025.
//

import SwiftUI

enum Tab: String {
    case home
    case explore
    case favorites
}

struct TabBar: View {
    @Binding var selectedTab: Tab

    var body: some View {
        VStack {
            Spacer()
            HStack {
                tabButton(for: .home, imageName: "house.fill")
                tabButton(for: .explore, imageName: "magnifyingglass")
                tabButton(for: .favorites, imageName: "heart.fill")
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .padding(.horizontal, 20)
            .background(Color.black.shadow(radius: 10))
        }
        .edgesIgnoringSafeArea(.bottom)
    }

    func tabButton(for tab: Tab, imageName: String) -> some View {
        Button(action: {
            withAnimation { selectedTab = tab }
        }) {
            Text("Home")
//            Image(systemName: imageName)
//                .resizable()
//                .scaledToFit()
//                .frame(width: 25, height: 25)
//                .foregroundColor(.white)
//                .frame(maxWidth: .infinity)
//                .opacity(selectedTab == tab ? 1 : 0.5)
        }
    }
}
