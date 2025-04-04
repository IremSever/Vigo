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
            .frame(width: 55)
            .font(.exoRegular(size: 12))
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
            .background(Color.purple.opacity(0.35))
            .cornerRadius(10)
            .foregroundColor(.white)
    }
}


struct TagViewOrange: View {
    var text: String
    
    var body: some View {
        Text(text)
            .frame(width: 48)
            .font(.exoRegular(size: 12))
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
            .background(Color.orange.opacity(0.35))
            .cornerRadius(10)
            .foregroundColor(.white)
    }
}

