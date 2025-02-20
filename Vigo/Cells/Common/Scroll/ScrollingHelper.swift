//
//  ScrollingHelper.swift
//  Vigo
//
//  Created by İrem Sever on 20.02.2025.
//

import SwiftUI

protocol ScrollingHelper {
    func getSizeForIndex(_ index: Int, selectedIndex: Int) -> CGFloat
    func getYOffsetForIndex(_ index: Int, selectedIndex: Int) -> CGFloat
    func scrollToIndex(_ index: Int, proxy: ScrollViewProxy?)
}

extension ScrollingHelper {
    func getSizeForIndex(_ index: Int, selectedIndex: Int) -> CGFloat {
        let diff = abs(index - selectedIndex)
        switch diff {
        case 0: return 200
        case 1: return 100
        default: return 0
        }
    }

    func getYOffsetForIndex(_ index: Int, selectedIndex: Int) -> CGFloat {
        let diff = abs(index - selectedIndex)
        switch diff {
        case 0: return 0
        case 1: return 0
        default: return 0
        }
    }

    func scrollToIndex(_ index: Int, proxy: ScrollViewProxy?) {
        DispatchQueue.main.async {
            withAnimation {
                proxy?.scrollTo(index, anchor: .center)
            }
        }
    }
}
