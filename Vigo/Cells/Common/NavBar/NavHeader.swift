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
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            
            BlurView(style: .systemMaterialDark)
                .frame(height: interpolatedHeight() + 30)
                .opacity(opacityView())
                .ignoresSafeArea(edges: .top)
            
            HStack {
                if let appImage = UIImage(named: app) {
                    SwiftUI.Image(uiImage: appImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: brandIconSize() + 10, height: brandIconSize() + 10)
                        .padding(.leading, 12)
                } else {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        SwiftUI.Image(systemName: app)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: iconSize() * 0.8, height: iconSize() * 0.8)
                            .padding(.leading, 12)
                            .foregroundColor(.white)
                    }
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
                        .padding(.trailing, 12)
                }
            }
            .offset(y: pushupOffset())
            .padding(.top, 10)
            .padding(.bottom, 10)
            .padding(.horizontal, 16)
            
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .animation(.easeIn, value: scrollOffset)
        
    }
}


