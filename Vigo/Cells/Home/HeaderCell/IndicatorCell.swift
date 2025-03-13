//
//  IndicatorCell.swift
//  Vigo
//
//  Created by İrem Sever on 2.02.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct IndicatorCell: View {
    let totalPages: Int
    let currentIndex: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<(totalPages), id: \.self) { index in
                Group {
                    if currentIndex == index {
                        Capsule()
                            .frame(width: 40, height: 4)
                            .foregroundColor(.orange)
                    } else {
                        Capsule()
                            .frame(width: 20, height: 4)
                            .foregroundColor(.white)
                    }
                }
                .foregroundColor(currentIndex == index ? .orange : .gray.opacity(0.8))
            }
        }
        .padding()
    }
}
