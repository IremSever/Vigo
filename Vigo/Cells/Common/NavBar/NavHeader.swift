//
//  NavHeader.swift
//  Vigo
//
//  Created by IREM SEVER on 12.02.2025.
//
import SwiftUI

struct NavHeader: View, NavAnimation {
    @Binding var scrollOffset: CGFloat
    var app: String
    var live: String
    var icon: String

    var body: some View {
        ZStack {
            SwiftUI.Image("navbar")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: interpolatedHeight() + 30)
                .blur(radius: 50)
                .opacity(opacityView())
                .clipped()
                .ignoresSafeArea(.all)

            HStack {
                if let appImage = UIImage(named: app) {
                    SwiftUI.Image(uiImage: appImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: brandIconSize(), height: brandIconSize())
                        .padding(.leading, 8)
                } else {
                    SwiftUI.Image(systemName: app)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: iconSize(), height: iconSize())
                        .padding(.leading, 8)
                        .foregroundColor(.white)
                }
                Spacer()
                
                HStack {
                    SwiftUI.Image(live)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: liveIconSize(), height: liveIconSize())
                        .padding(16)
                   

                    SwiftUI.Image(systemName: icon)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .foregroundColor(.white)
                        .frame(width: iconSize(), height: iconSize())
                }
            }
            .offset(y: pushupOffset())
            .padding(.top, 10)
            .padding(.horizontal, 16)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .animation(.easeIn, value: scrollOffset)
    }
}
