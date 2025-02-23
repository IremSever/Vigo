//
//  ClearNavBar.swift
//  Vigo
//
//  Created by İrem Sever on 23.02.2025.
//

import SwiftUI

struct ClearNavBar: ViewModifier {
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func clearNavigationBar() -> some View {
        self.modifier(ClearNavBar())
    }
}
