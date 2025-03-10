//
//  IconButton.swift
//  Vigo
//
//  Created by İrem Sever on 23.02.2025.
//

import SwiftUI
struct IconButton: View {
    var icon: String
    var title: String?
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                SwiftUI.Image(systemName: icon)
                    .foregroundColor(.white.opacity(0.8))
                    .font(.exoRegular(size: 20))
                if let title = title {
                    Text(title)
                }
            }
        }
    }
}
