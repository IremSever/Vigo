//
//  JustifiedText.swift
//  Vigo
//
//  Created by IREM SEVER on 18.03.2025.
//



                
import SwiftUI
import UIKit

struct JustifiedText: UIViewRepresentable {
    private let text: String
    private let font: UIFont
    @Binding var isExpanded: Bool

    init(_ text: String, isExpanded: Binding<Bool>, font: UIFont = .systemFont(ofSize: 14)) {
        self.text = text
        self._isExpanded = isExpanded
        self.font = font
    }

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.font = font
        textView.textAlignment = .justified
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.textColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textView.widthAnchor.constraint(equalToConstant: 220)
        ])
        
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.layoutIfNeeded()

        if isExpanded {
            uiView.textContainer.maximumNumberOfLines = 0
            uiView.textContainer.lineBreakMode = .byWordWrapping
        } else {
            let maxHeight: CGFloat = (uiView.font?.lineHeight ?? 16) * 5
            uiView.textContainer.maximumNumberOfLines = 10
            uiView.textContainer.lineBreakMode = .byTruncatingTail
            uiView.frame.size.height = maxHeight
        }
    }

}
