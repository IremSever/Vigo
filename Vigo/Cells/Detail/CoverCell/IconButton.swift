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
    var isSystemImage: Bool = false
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Group {
                    if isSystemImage {
                        SwiftUI.Image(systemName: icon)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 15, height: 15)
                
                            .foregroundColor(Color(hex: "#d9d9d9"))
                            .fontWeight(.bold)
                    } else {
                        SwiftUI.Image(icon)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 15, height: 15)
                    }
                }
                if let title = title {
                    Text(title)
                }
            }
        }
    }
}
