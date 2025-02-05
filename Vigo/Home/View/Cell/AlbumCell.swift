//
//  AlbumCell.swift
//  Vigo
//
//  Created by İrem Sever on 2.02.2025.
//
import SwiftUI
import SDWebImageSwiftUI
struct AlbumCell: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var selectedIndex: Int = 2
    @State private var dragOffset: CGFloat = 0

    var body: some View {
        GeometryReader { proxy in
            let screenWidth = proxy.size.width

            ZStack {
                if let homeData = viewModel.homeModel?.data,
                   let selectedNews = homeData[selectedIndex].videos?.first,
                   let bgImageUrl = URL(string: selectedNews.image) {
                    WebImage(url: bgImageUrl)
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .blur(radius: 20)
                        .opacity(0.4)
                }
                Spacer()
                VStack {
                    Spacer()

                    ZStack {
                        if let homeData = viewModel.homeModel?.data {
                            ForEach(homeData.indices, id: \.self) { index in
                                if let newsItem = homeData[index].news?.first,
                                   let imageUrl = URL(string: newsItem.image ?? "") {

                                    let offsetX = calculateOffset(index: index, selectedIndex: selectedIndex, dragOffset: dragOffset)
                                    let scale = calculateScale(index: index, selectedIndex: selectedIndex, dragOffset: dragOffset)
                                    let opacity = calculateOpacity(index: index, selectedIndex: selectedIndex)
                                    let zIndex = calculateZIndex(index: index, selectedIndex: selectedIndex)

                                    WebImage(url: imageUrl)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: screenWidth * 0.5)
                                        .cornerRadius(20)
                                        .shadow(radius: selectedIndex == index ? 15 : 5)
                                        .scaleEffect(scale)
                                        .opacity(opacity)
                                        .offset(x: offsetX)
                                        .animation(.easeInOut(duration: 0.3), value: selectedIndex)
                                        .zIndex(zIndex)
                                }
                            }
                        }
                    }
                    .frame(height: 400)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                dragOffset = value.translation.width
                            }
                            .onEnded { value in
                                let threshold: CGFloat = 50
                                if value.translation.width < -threshold {
                                    if selectedIndex < (viewModel.homeModel?.data.count ?? 1) - 1 {
                                        selectedIndex += 1
                                    }
                                } else if value.translation.width > threshold {
                                    if selectedIndex > 0 {
                                        selectedIndex -= 1
                                    }
                                }
                                dragOffset = 0
                            }
                    )

                    if let homeData = viewModel.homeModel?.data,
                       let selectedMovie = homeData[selectedIndex].news?.first {
                        VStack {
                            Text(selectedMovie.title)
                                .font(.system(size: 26, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding(.top, 10)
                    }

                    Spacer()
                }
            }
        }
    }

    func calculateOffset(index: Int, selectedIndex: Int, dragOffset: CGFloat) -> CGFloat {
        let distance = index - selectedIndex
        let baseOffset = CGFloat(distance * 40)
        return baseOffset + (dragOffset / 10)
    }

    func calculateScale(index: Int, selectedIndex: Int, dragOffset: CGFloat) -> CGFloat {
        let distance = abs(index - selectedIndex)
        let baseScale = distance == 0 ? 1.2 : (distance == 1 ? 1.0 : 0.85)
        return baseScale + (dragOffset / 1000)
    }

    func calculateOpacity(index: Int, selectedIndex: Int) -> Double {
        let distance = abs(index - selectedIndex)
        return distance == 0 ? 1.0 : (distance == 1 ? 0.6 : 0.3)
    }

    func calculateZIndex(index: Int, selectedIndex: Int) -> Double {
        return index == selectedIndex ? 10 : Double(-abs(index - selectedIndex))
    }
}
