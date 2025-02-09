//
//  Backdrop.swift
//  Vigo
//
//  Created by IREM SEVER on 7.02.2025.
//
import SwiftUI
import SDWebImageSwiftUI

struct Backdrop: View {
    let images: [String]
    @Binding var scrollProgressX: CGFloat
    @Binding var scrollOffsetY: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(images.indices, id: \.self) { index in
                    WebImage(url: URL(string: images[index]))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .opacity(Double(1 - abs(CGFloat(index) - scrollProgressX))) 
                }
            }
            .compositingGroup()
            .blur(radius: 30, opaque: true)
            .overlay {
                Rectangle()
                    .fill(Color.black.opacity(0.35))
            }
            .mask {
                LinearGradient(gradient: Gradient(colors: [
                    .black, .black, .black, .black, .black.opacity(0.5), .clear
                ]), startPoint: .top, endPoint: .bottom)
            }
            .offset(y: scrollOffsetY < 0 ? scrollOffsetY : 0)
        }
        .padding(.bottom, -60)
        .padding(.top, -100)
    }
}
