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
                HomeView()
                    .tag(Tab.home)
                    .toolbar(.hidden, for: .tabBar) 
                
                ExploreView()
                    .tag(Tab.explore)
                    .toolbar(.hidden, for: .tabBar)

                FavoritesView()
                    .tag(Tab.favorites)
                    .toolbar(.hidden, for: .tabBar)
            }
            
            VStack {
                Spacer()
                TabBar(selectedTab: $selectedTab)
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}


