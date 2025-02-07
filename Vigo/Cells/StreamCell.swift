import SwiftUI
import SDWebImageSwiftUI

struct StreamCell: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                if let homeData = viewModel.homeModel?.data {
                    ForEach(homeData.indices, id: \.self) { index in
                        let section = homeData[index]
                        
                        if let streams = section.streams {
                            ForEach(streams, id: \.title) { stream in
                                VStack {
                                    if let imageUrl = URL(string: stream.image) {
                                        WebImage(url: imageUrl)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 150, height: 150)
                                            .cornerRadius(10)
                                            .clipped()
                                    }
                                    Text(stream.title)
                                        .font(.headline)
                                        .foregroundColor(.orange)
                                        .padding(.top, 2)
                                    
                                    Text("\(stream.hour):\(stream.minute)")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .padding(.bottom, 2)
                                    
                                    if stream.isLive {
                                        Text("LIVE")
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                            .foregroundColor(.orange)
                                            .background(Capsule()
                                                            .fill(Color.yellow)
                                                            .frame(width: 50, height: 20))
                                        
                                            
                                    }
                                }
                                .padding()
                                .background(stream.isLive ? Color.yellow.opacity(0.6) : Color.gray.opacity(0.6))
                                .cornerRadius(12)
                                .shadow(radius: 5)
                                .frame(width: 260, height: 260)
                            }
                        }
                    }
                }
            }
        }
    }
}
