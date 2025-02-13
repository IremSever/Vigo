//
//  MyView.swift
//  Vigo
//
//  Created by IREM SEVER on 12.02.2025.
//

import SwiftUI

struct ScrollOffsetBg: View {
    var onOffsetChange: (CGFloat) -> Void
    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: ViewOffsetKey.self, value: geometry.frame(in: .global).minY)
                .onPreferenceChange(ViewOffsetKey.self, perform: onOffsetChange)
        }
    }
}
