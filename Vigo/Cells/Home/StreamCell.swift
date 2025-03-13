import SwiftUI
import SDWebImageSwiftUI

struct StreamCell: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                if let homeData = viewModel.homeModel?.data {
                    ForEach(homeData.indices, id: \.self) { index in
                        let section = homeData[index]
                        
                        if let streams = section.streams {
                            ForEach(streams.indices, id: \.self) { streamIndex in
                                let stream = streams[streamIndex]
                                ZStack {
                                    Text("\(stream.hour):\(stream.minute)")
                                        .font(.exoBlack(size: 50))
                                        .foregroundColor(stream.isLive ? .orange.opacity(0.85) : .purple.opacity(0.5))
                                        .shadow(radius: 10)
                                        .rotationEffect(.degrees(270))
                                        .position(x: 18, y: 110)
                                    
                                    if let imageUrl = URL(string: stream.image) {
                                        WebImage(url: imageUrl)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 200)
                                            .cornerRadius(20)
                                            .clipped()
                                            .overlay(
                                                LinearGradient(
                                                    gradient: Gradient(colors: stream.isLive ? [Color.black.opacity(0.5), Color.clear] : [Color.black.opacity(0.5), Color.clear]),
                                                    startPoint: .bottom,
                                                    endPoint: stream.isLive ? UnitPoint(x: 0.5, y: 0.5) : .top
                                                )
                                                .cornerRadius(20)
                                            )
                                    }
                                    if stream.isLive {
                                        Text("LIVE")
                                            .font(.exoSemiBold(size: 14))
                                            .foregroundColor(.white)
                                            .padding(.vertical, 3)
                                            .padding(.horizontal, 8)
                                            .background(
                                                Rectangle()
                                                    .fill(Color.orange.opacity(0.75))
                                                   
                                            )
                                            .position(x: 50, y: 110)
                                            .frame(width: 100, height: 40, alignment: .center)
                                    }
                                    
                                }
                                .frame(width: 210, height: 220)
                                .cornerRadius(20)
                                .shadow(radius: 5)
                            }
                        }
                    }
                }
            }.padding(.horizontal, 12)
        }
       
    }
}
