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
            Color.clear
                .frame(height: interpolatedHeight())
                .background(Color(.black).opacity(opacityView()))
                .edgesIgnoringSafeArea(.top)

            HStack {
                SwiftUI.Image(app)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: brandIconSize(), height: brandIconSize())
                    .padding(.leading, 16)
               
          
                Spacer()
                VStack{
                    SwiftUI.Image(live)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: liveIconSize(), height: liveIconSize())


                    SwiftUI.Image(systemName: icon)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .foregroundColor(.white)
                        .frame(width: iconSize(), height: iconSize())
                }
                .padding(.trailing, 16)

            }
            .offset(y: pushupOffset())
            .padding(.top, 10) 
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .animation(.easeIn, value: scrollOffset)
    }
}
