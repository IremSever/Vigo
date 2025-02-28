//
//  TurkishTextFormatter.swift
//  Vigo
//
//  Created by İrem Sever on 26.02.2025.
//

import Foundation
import SwiftUI

protocol TurkishTextFormatter {
    func formattedTurkishTitle(_ text: String) -> String
}

extension TurkishTextFormatter {
    func formattedTurkishTitle(_ text: String) -> String {
        return NSString(string: text)
            .lowercased(with: Locale(identifier: "tr_TR"))
            .replacingOccurrences(of: "i", with: "İ")
            .replacingOccurrences(of: "ı", with: "I")
            .capitalized(with: Locale(identifier: "tr_TR"))
    }
}
