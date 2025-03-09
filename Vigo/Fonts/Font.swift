//
//  Font.swift
//  Vigo
//
//  Created by İrem Sever on 8.03.2025.
//
//

import SwiftUI

extension Font {
    static func exoThin(size: CGFloat) -> Font {
        return Font.custom("Exo2-Thin", size: size)
    }

    static func exoRegular(size: CGFloat) -> Font {
        return Font.custom("Exo2-Regular", size: size)
    }

    static func exoMedium(size: CGFloat) -> Font {
        return Font.custom("Exo2-Medium", size: size)
    }

    static func exoSemiBold(size: CGFloat) -> Font {
        return Font.custom("Exo2-SemiBold", size: size)
    }

    static func exoBold(size: CGFloat) -> Font {
        return Font.custom("Exo2-Bold", size: size)
    }

    static func exoBlack(size: CGFloat) -> Font {
        return Font.custom("Exo2-Black", size: size)
    }

    static func exoLightItalic(size: CGFloat) -> Font {
        return Font.custom("Exo2-LightItalic", size: size)
    }
}
