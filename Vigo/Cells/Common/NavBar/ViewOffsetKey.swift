//
//  ViewOffsetKey.swift
//  Vigo
//
//  Created by IREM SEVER on 12.02.2025.
//

import SwiftUI

struct ViewOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
