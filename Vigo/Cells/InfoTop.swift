//
//  SwiftUIView.swift
//  Vigo
//
//  Created by IREM SEVER on 7.02.2025.
//

import SwiftUI

struct InfoTop: View {
    var body: some View {
        HStack {
            SwiftUI.Image(systemName: "staroflife")
                .font(.largeTitle)
                .foregroundStyle(.white, .fill)
            
            Text("irems")
                .font(.callout)
                .foregroundStyle(.white)
                .fontWeight(.semibold)
            
            
            
            Spacer()
            
            SwiftUI.Image(systemName: "square.and.arrow.up.circle.fill")
                .font(.largeTitle)
                .foregroundStyle(.white, .fill)
            
            SwiftUI.Image(systemName: "bell.circle.fill")
                .font(.largeTitle)
                .foregroundStyle(.white, .fill)
            
        }
    }
}
//
//#Preview {
//    InfoTop()
//}

