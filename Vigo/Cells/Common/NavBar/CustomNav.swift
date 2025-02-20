//
//  CustomNav.swift
//  Vigo
//
//  Created by IREM SEVER on 12.02.2025.
//
//

import SwiftUI
struct CustomNav<Content: View>: View {
    @State var scrollOffset: CGFloat = 0
    var app: String
    var live: String
    var icon: String
    let content: Content


    init(app: String, live: String, icon: String, @ViewBuilder content: () -> Content) {
        self.app = app
        self.live = live
        self.icon = icon
        self.content = content()
    }

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                ScrollOffsetBg { offset in
                    self.scrollOffset = offset - geo.safeAreaInsets.top
                }
                .frame(height: 0)
                content
            }
            .background {
                Rectangle()
                    .fill(.black.gradient)
                    .scaleEffect(y: -1)
                    .ignoresSafeArea(edges: .all)
            }
            .safeAreaInset(edge: .top, content: {
                Color.clear.frame(height: 40)
            })
            .overlay {
                NavHeader(scrollOffset: $scrollOffset, app: app, live: live, icon: icon)
                    .zIndex(1)
            }
        }
    }
}
