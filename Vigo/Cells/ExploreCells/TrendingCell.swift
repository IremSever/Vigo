//
//  TrendingCell.swift
//  Vigo
//
//  Created by IREM SEVER on 13.02.2025.
//
//import SwiftUI
//import SDWebImageSwiftUI
//
//struct TrendingCell: View {
//    @ObservedObject var viewModel: ExploreViewModel
//    @State private var selectedIndex: Int = 0
//    @State private var scrollProxy: ScrollViewProxy?
//
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack {
//                if let exploreData = viewModel.exploreModel?.data {
//                    let allNewsItems = exploreData.flatMap { $0.news ?? [] }
//
//                    if allNewsItems.indices.contains(selectedIndex) {
//                        let selectedItem = allNewsItems[selectedIndex]
//
//                        if let imageUrl = selectedItem.image, let validUrl = URL(string: imageUrl) {
//                            WebImage(url: validUrl)
//                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                                .frame(width: geometry.size.width, height: geometry.size.height)
//                                .clipped()
//                                .overlay(
//                                    LinearGradient(gradient: Gradient(colors: [.black.opacity(0.8), .clear]), startPoint: .top, endPoint: .bottom)
//                                )
//                        }
//                    }
//
//                    VStack {
//                        Spacer()
//
//                        ScrollView(.horizontal, showsIndicators: false) {
//                            ScrollViewReader { proxy in
//                                HStack(spacing: 15) {
//                                    ForEach(allNewsItems.indices, id: \.self) { index in
//                                        let newsItem = allNewsItems[index]
//                                        let size: CGFloat = getSizeForIndex(index, selectedIndex: selectedIndex)
//
//                                        VStack {
//                                            if let imageUrl = newsItem.image, let validUrl = URL(string: imageUrl) {
//                                                WebImage(url: validUrl)
//                                                    .resizable()
//                                                    .scaledToFill()
//                                                    .frame(width: size, height: size)
//                                                    .clipShape(Circle())
//                                                    .overlay(
//                                                        Circle()
//                                                            .stroke(selectedIndex == index ? Color.blue : Color.clear, lineWidth: 3)
//                                                    )
//                                                    .onTapGesture {
//                                                        withAnimation {
//                                                            selectedIndex = index
//                                                            scrollToIndex(index, proxy: proxy)
//                                                        }
//                                                    }
//                                            }
//                                            Text(newsItem.title ?? "")
//                                                .font(.caption)
//                                                .foregroundColor(.white)
//                                                .lineLimit(1)
//                                        }
//                                        .id(index)
//                                    }
//                                }
//                                .padding(.horizontal)
//                                .frame(minWidth: geometry.size.width,
//                                       idealWidth: CGFloat(allNewsItems.count) * 100,
//                                       maxWidth: .infinity,
//                                       alignment: .center)
//                                .onAppear {
//                                    scrollProxy = proxy
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//            .gesture(
//                DragGesture()
//                    .onEnded { value in
//                        let threshold: CGFloat = 50
//                        let allNewsItemsCount = viewModel.exploreModel?.data.flatMap { $0.news ?? [] }.count ?? 1
//
//                        if value.translation.width < -threshold, selectedIndex < allNewsItemsCount - 1 {
//                            withAnimation {
//                                selectedIndex += 1
//                                scrollToIndex(selectedIndex, proxy: scrollProxy)
//                            }
//                        } else if value.translation.width > threshold, selectedIndex > 0 {
//                            withAnimation {
//                                selectedIndex -= 1
//                                scrollToIndex(selectedIndex, proxy: scrollProxy)
//                            }
//                        }
//                    }
//            )
//            .frame(width: geometry.size.width, height: geometry.size.height)
//            .edgesIgnoringSafeArea(.top)
//            .edgesIgnoringSafeArea(.bottom)
//        }
//    }
//
//    private func getSizeForIndex(_ index: Int, selectedIndex: Int) -> CGFloat {
//        if index == selectedIndex {
//            return 80
//        } else if abs(index - selectedIndex) <= 2 {
//            return 50
//        } else {
//            return 30
//        }
//    }
//
//    private func scrollToIndex(_ index: Int, proxy: ScrollViewProxy?) {
//        DispatchQueue.main.async {
//            withAnimation {
//                proxy?.scrollTo(index, anchor: .center)
//            }
//        }
//    }
//}
import SwiftUI
import SDWebImageSwiftUI

struct TrendingCell: View {
    @ObservedObject var viewModel: ExploreViewModel
    @State private var selectedIndex: Int = 0
    @State private var scrollProxy: ScrollViewProxy?

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if let exploreData = viewModel.exploreModel?.data {
                    let allNewsItems = exploreData.flatMap { $0.news ?? [] }

                    if allNewsItems.indices.contains(selectedIndex) {
                        let selectedItem = allNewsItems[selectedIndex]

                        if let imageUrl = selectedItem.image, let validUrl = URL(string: imageUrl) {
                            WebImage(url: validUrl)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .clipped()
                                .overlay(
                                    LinearGradient(gradient: Gradient(colors: [.black.opacity(0.8), .clear]), startPoint: .top, endPoint: .bottom)
                                )
                        }
                    }

                    VStack {
                        Spacer()

                        ScrollView(.horizontal, showsIndicators: false) {
                            ScrollViewReader { proxy in
                                HStack(spacing: 15) {
                                    ForEach(allNewsItems.indices, id: \.self) { index in
                                        let newsItem = allNewsItems[index]
                                        let size = getSizeForIndex(index, selectedIndex: selectedIndex)
                                        let yOffset = getYOffsetForIndex(index, selectedIndex: selectedIndex)

                                        VStack {
                                            if let imageUrl = newsItem.image, let validUrl = URL(string: imageUrl) {
                                                WebImage(url: validUrl)
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: size, height: size)
                                                    .clipShape(Circle())
                                                    .overlay(
                                                        Circle()
                                                            .stroke(selectedIndex == index ? Color.blue : Color.clear, lineWidth: 3)
                                                    )
                                                    .onTapGesture {
                                                        withAnimation {
                                                            selectedIndex = index
                                                            scrollToIndex(index, proxy: proxy)
                                                        }
                                                    }
                                            }
                                            Text(newsItem.title ?? "")
                                                .font(.caption)
                                                .foregroundColor(.white)
                                                .lineLimit(1)
                                        }
                                        .frame(width: 100, height: 300)
                                        .offset(y: yOffset)
                                        .clipped()

                                    }
                                }
                                .padding(.horizontal)
                                .frame(minWidth: geometry.size.width,
                                       idealWidth: CGFloat(allNewsItems.count) * 100,
                                       maxWidth: .infinity,
                                       alignment: .center)
                                .onAppear {
                                    scrollProxy = proxy
                                }
                            }
                        }
                    }
                }
            }
            .gesture(
                DragGesture()
                    .onEnded { value in
                        let threshold: CGFloat = 50
                        let allNewsItemsCount = viewModel.exploreModel?.data.flatMap { $0.news ?? [] }.count ?? 1

                        if value.translation.width < -threshold, selectedIndex < allNewsItemsCount - 1 {
                            withAnimation {
                                selectedIndex += 1
                                scrollToIndex(selectedIndex, proxy: scrollProxy)
                            }
                        } else if value.translation.width > threshold, selectedIndex > 0 {
                            withAnimation {
                                selectedIndex -= 1
                                scrollToIndex(selectedIndex, proxy: scrollProxy)
                            }
                        }
                    }
            )
            .frame(width: geometry.size.width, height: geometry.size.height)
            .edgesIgnoringSafeArea(.top)
            .edgesIgnoringSafeArea(.bottom)
        }
    }

    private func getSizeForIndex(_ index: Int, selectedIndex: Int) -> CGFloat {
        let diff = abs(index - selectedIndex)
        switch diff {
        case 0: return 100
        case 1: return 70
        case 2: return 30
        default: return 45
        }
    }

    private func getYOffsetForIndex(_ index: Int, selectedIndex: Int) -> CGFloat {
        let diff = abs(index - selectedIndex)
        switch diff {
        case 0: return -80
        case 1: return -45
        case 2: return 0
        default: return 0
        }
    }


    private func scrollToIndex(_ index: Int, proxy: ScrollViewProxy?) {
        DispatchQueue.main.async {
            withAnimation {
                proxy?.scrollTo(index, anchor: .center)
            }
        }
    }
}
