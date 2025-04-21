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
            tabButton(for: .home, imageName: "home")
            tabButton(for: .explore, imageName: "tabexplore2")
            tabButton(for: .favorites, imageName: "user_")
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(Color.black)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.white.opacity(0.5), radius: 5, x: 0, y: 0)
        .padding(.horizontal, 30)
        .padding(.vertical, 30)
        .opacity(1)
    }
    
    func tabButton(for tab: Tab, imageName: String) -> some View {
        Button(action: {
            withAnimation { selectedTab = tab }
        }) {
            let image = SwiftUI.Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
            
            if imageName == "user_" {
                image
                    .cornerRadius(5)
                    .overlay(
                        Group {
                            if selectedTab == tab {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.white, lineWidth: 1)
                            }
                        }
                    )
                    .frame(maxWidth: .infinity)
                    .opacity(selectedTab == tab ? 0.8 : 0.5)
            } else if imageName == "tabexplore2" {
                image
                    .frame(width: 40, height: 35)
                    .frame(maxWidth: .infinity)
                    .opacity(selectedTab == tab ? 1 : 0.5)
                
            }else {
                image
                    .frame(maxWidth: .infinity)
                    .opacity(selectedTab == tab ? 1 : 0.5)
            }
        }
    }
}
