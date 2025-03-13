//
//  UserCard.swift
//  Vigo
//
//  Created by IREM SEVER on 13.03.2025.
//

import SwiftUI

struct UserCard: View {
    @State private var scrollProgressX: CGFloat = 0
    @State private var scrollOffsetY: CGFloat = 0
    @State private var isUser: Bool = true
    var body: some View {
        VStack {
            
       
                VStack {
                    SwiftUI.Image("user_")
                        .resizable()
                        .cornerRadius(20)
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .padding(.top, 20)
                        .padding(.bottom, 0)
                  
                    Text("User")
                        .font(.exoBold(size: 20))
                        .foregroundColor(.orange)
                  
                }
          
         
            .frame(width: UIScreen.main.bounds.width, height: 150)
            .background(
                Backdrop(
                    images: ["https://t4.ftcdn.net/jpg/09/04/60/51/360_F_904605193_o8KuD3pemsdxabWvwi41YraFy6kmUyHX.jpg"],
                    scrollProgressX: $scrollProgressX,
                    scrollOffsetY: $scrollOffsetY, isUser: $isUser
                )
            )
        }
    }
}

#Preview {
    UserCard()
}
