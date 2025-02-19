//
//  BottomButton.swift
//  Vigo
//
//  Created by İrem Sever on 19.02.2025.
//

import SwiftUI

struct BottomButton: View {
    var body: some View {
            HStack(spacing: 20) {
                Button(action: { print("My List tapped") }) {
//                    VStack {
//                        SwiftUI.Image(systemName: "plus")
//                            .font(.title2)
//                            .foregroundColor(.white)
//                        Text("My List")
//                            .font(.caption)
//                            .foregroundColor(.white)
//                    }
                    HStack {
                        SwiftUI.Image(systemName: "plus")
                        Text("List")
                    }
                    .frame(width: 100, height: 40)
                    .background(Color.purple.opacity(0.35))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
                Button(action: { print("Play tapped") }) {
                    HStack {
                        SwiftUI.Image(systemName: "play.fill")
                        Text("Play")
                    }
                    .frame(width: 100, height: 40)
                    .background(Color.purple.opacity(0.35))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding(.top, 10)
        }
    }
