//
//  ContentView.swift
//  Vigo
//
//  Created by İrem Sever on 5.02.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .home
 
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {

                HomeVC()
                    .tag(Tab.home)
                ExploreVC()
                    .tag(Tab.explore)
                FavoritesVC()
                    .tag(Tab.favorites)
            }
            VStack {
                Spacer()
                TabBar(selectedTab: $selectedTab)
            }
           
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

#Preview {
    ContentView()
}

