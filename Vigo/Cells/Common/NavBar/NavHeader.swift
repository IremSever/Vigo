//
//  NavHeader.swift
//  Vigo
//
//  Created by IREM SEVER on 12.02.2025.
//

import SwiftUI

struct NavHeader: View {
    var scrollOffset: CGFloat
    var title: String
    var icon: String
    
    var body: some View {
        ZStack {
            Color.clear
                .frame(height: interpolatedHeight())
                .background(Color(.black).opacity(opacityView()))
                .edgesIgnoringSafeArea(.top)
            
            HStack {
                Text(title).bold()
                    .font(.system(size: interpolatedText()))
                    .foregroundColor(.white)
                
                Spacer()
                
                SwiftUI.Image(systemName: icon)
                    .font(.system(size: iconSize()))
                    .foregroundColor(.white)
            }
            .offset(y: pushupOffset())
            .padding()
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .animation(.easeIn, value: scrollOffset)
    }
 
    //define a function to calculate the height of an element based on the scroll offset
    private func interpolatedHeight() -> CGFloat {
        //starting height of the element before scrolling starts
        let startHeight: CGFloat = 100
        
        //ending height of the element after scrolling
        let endHeight: CGFloat = 85
        
        //the amount of scroll required to transtion from startH to endH
        let transtionOffset: CGFloat = 35
        
        //calculates the progress of the transition as a fraction between 0 and 1
        //it uses the current scroll offset divided by the transitionOFfset
        //it the result is less than 0, it uses 0. if it's more than 1, it uses 1
        let progress = min(max(scrollOffset / transtionOffset, 0), 1)
        
        //calculates the current height based on the progress
        //if progress is 0, the height is startH. If progress is 1, the height is endH
        //It interpolates between these two heights based on the progress
        return endHeight + (startHeight - endHeight) * progress
    }
    
    private func iconSize() -> CGFloat {
        let startHeight: CGFloat = 20
        
        let endHeight: CGFloat = 25
        
        let transtionOffset: CGFloat = 35
        
        let progress = min(max(scrollOffset / transtionOffset, 0), 1)
        
        return endHeight + (startHeight - endHeight) * progress
    }
    
    private func pushupOffset() -> CGFloat {
        let startHeight: CGFloat = -40
        
        let endHeight: CGFloat = -40
        
        let transtionOffset: CGFloat = 50
        
        let progress = min(max(scrollOffset / transtionOffset, 0), 1)
        
        return endHeight + (startHeight - endHeight) * progress
    }
    
    private func interpolatedText() -> CGFloat {
        let startHeight: CGFloat = 40
        
        let endHeight: CGFloat = 30
        
        let transtionOffset: CGFloat = 50
        
        let progress = min(max(scrollOffset / transtionOffset, 0), 1)
        
        return endHeight + (startHeight - endHeight) * progress
    }
    
    private func opacityView() -> CGFloat {
        let startOffset: CGFloat = 0
        
        let endOffset: CGFloat = 1
        
        let transtionOffset: CGFloat = 50
        
        let progress = min(max(scrollOffset / transtionOffset, 0), 1)
        
        return endOffset + (startOffset - endOffset) * progress
    }
}
