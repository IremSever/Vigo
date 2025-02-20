//
//  NavAnimation.swift
//  Vigo
//
//  Created by İrem Sever on 20.02.2025.
//

import SwiftUI

protocol NavAnimation {
    var scrollOffset: CGFloat { get set }
    func interpolatedHeight() -> CGFloat
    func brandIconSize() -> CGFloat
    func iconSize() -> CGFloat
    func pushupOffset() -> CGFloat
    func interpolatedText() -> CGFloat
    func opacityView() -> CGFloat 
}
    
    extension NavAnimation {
        func interpolatedHeight() -> CGFloat {
            let startHeight: CGFloat = 100 
            let endHeight: CGFloat = 85
            let transtionOffset: CGFloat = 35
            let progress = min(max(scrollOffset / transtionOffset, 0), 1)
            return endHeight + (startHeight - endHeight) * progress
        }
    
    func brandIconSize() -> CGFloat {
        let startHeight: CGFloat = 40
        let endHeight: CGFloat = 45
        let transtionOffset: CGFloat = 35
        let progress = min(max(scrollOffset / transtionOffset, 0), 1)
        return endHeight + (startHeight - endHeight) * progress
    }
        
    func liveIconSize() -> CGFloat {
        let startHeight: CGFloat = 55
        let endHeight: CGFloat = 60
        let transtionOffset: CGFloat = 35
        let progress = min(max(scrollOffset / transtionOffset, 0), 1)
        return endHeight + (startHeight - endHeight) * progress
    }
    
    func iconSize() -> CGFloat {
        let startHeight: CGFloat = 25
        let endHeight: CGFloat = 30
        let transtionOffset: CGFloat = 20
        let progress = min(max(scrollOffset / transtionOffset, 0), 1)
        return endHeight + (startHeight - endHeight) * progress
    }
    
    func pushupOffset() -> CGFloat {
        let startHeight: CGFloat = -40
        let endHeight: CGFloat = -40
        let transtionOffset: CGFloat = 50
        let progress = min(max(scrollOffset / transtionOffset, 0), 1)
        return endHeight + (startHeight - endHeight) * progress
    }
    
    func interpolatedText() -> CGFloat {
        let startHeight: CGFloat = 40
        let endHeight: CGFloat = 30
        let transtionOffset: CGFloat = 50
        let progress = min(max(scrollOffset / transtionOffset, 0), 1)
        return endHeight + (startHeight - endHeight) * progress
    }
    
    func opacityView() -> CGFloat {
        let startOffset: CGFloat = 0
        let endOffset: CGFloat = 1
        let transtionOffset: CGFloat = 30
        let progress = min(max(scrollOffset / transtionOffset, 0), 1)
        return endOffset + (startOffset - endOffset) * progress
    }
}
