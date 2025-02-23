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
    var body: some View {
        Button(action: {}) {
            HStack {
                SwiftUI.Image(systemName: icon)
                    .foregroundColor(.white.opacity(0.8))
                    .font(.system(size: 20))
                Text(title ?? "")
            }
        }
            
        
    }
}
