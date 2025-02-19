//
//  BottomButton.swift
//  Vigo
//
//  Created by İrem Sever on 19.02.2025.
//

import SwiftUI

struct BottomButton: View {
    var body: some View {
            HStack(spacing: 40) {
                Button(action: { print("My List tapped") }) {
                    VStack {
                        SwiftUI.Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(.white)
                        Text("My List")
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                }
                
                Button(action: { print("Play tapped") }) {
                    HStack {
                        SwiftUI.Image(systemName: "play.fill")
                        Text("Play")
                    }
                    .frame(width: 120, height: 40)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(8)
                }
                
                Button(action: { print("Info tapped") }) {
                    VStack {
                        SwiftUI.Image(systemName: "info.circle")
                            .font(.title2)
                            .foregroundColor(.white)
                        Text("Info")
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(.top, 10)
        }
    }
