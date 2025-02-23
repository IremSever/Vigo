//
//  TagView.swift
//  Vigo
//
//  Created by İrem Sever on 23.02.2025.
//

import SwiftUI

struct TagView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 12))
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            .background(Color.purple.opacity(0.35))
            .cornerRadius(10)
            .foregroundColor(.white)
    }
}
