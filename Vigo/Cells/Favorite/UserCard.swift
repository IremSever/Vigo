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
    @State private var showUsers: Bool = false

    var body: some View {
        VStack {
            VStack {
                SwiftUI.Image("user_")
                    .resizable()
                    .cornerRadius(20)
                    .scaledToFill()
                    .frame(width: 90, height: 90)
                    .padding(.top, 20)
                    .padding(.bottom, 0)

                VStack {
                    Text("user")
                        .font(.exoBold(size: 16))
                        .foregroundColor(.orange)
                        .padding(.bottom, 12)

                    Button(action: {
                        withAnimation {
                            showUsers.toggle()
                        }
                    }) {
                        SwiftUI.Image(systemName: "chevron.down")
                            .foregroundColor(.orange)
                            .font(.system(size: 14))
                            .rotationEffect(.degrees(showUsers ? 180 : 0))
                    }
                }
            }

            if showUsers {
                VStack {
                    Text("User-2")
                        .font(.exoMedium(size: 16))
                        .foregroundColor(.purple)
                    Text("User-3")
                        .font(.exoMedium(size: 16))
                        .foregroundColor(.purple)
                }
                .transition(.opacity)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: showUsers ? 200 : 120)
        .background(
            Backdrop(
                images: ["https://t4.ftcdn.net/jpg/09/04/60/51/360_F_904605193_o8KuD3pemsdxabWvwi41YraFy6kmUyHX.jpg"],
                scrollProgressX: $scrollProgressX,
                scrollOffsetY: $scrollOffsetY, isUser: $isUser
            )
        )
    }
}

#Preview {
    UserCard()
}
