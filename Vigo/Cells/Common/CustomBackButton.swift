//
//  CommonButton.swift
//  Vigo
//
//  Created by İrem Sever on 23.02.2025.
//

import SwiftUI

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            SwiftUI.Image(systemName: "")
                .font(.system(size: 20).bold())
                .foregroundColor(.white)
        }
    }
}

