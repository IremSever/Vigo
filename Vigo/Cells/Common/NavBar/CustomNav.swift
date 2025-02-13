//
//  CustomNav.swift
//  Vigo
//
//  Created by IREM SEVER on 12.02.2025.
//

import SwiftUI

struct CustomNav<Content: View > : View {
    var title, icon: String
    let content: Content
    @State private var scrollOffset: CGFloat = 0
    
    init(title: String, icon: String, @ViewBuilder content: () -> Content) {
        self.title = title
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
            .padding(.top, 100)
            .background(Color.clear)
            .ignoresSafeArea()
            .safeAreaInset(edge: .top, content: {
                Color.clear
                    .frame(height: 40)
            })
            .overlay {
                NavHeader(scrollOffset: scrollOffset, title: title, icon: icon).zIndex(1)
            }
        }

                      
    }
}

//#Preview {
//    CustomNav()
//}
