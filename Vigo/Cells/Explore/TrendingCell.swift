//
//  TrendingCell.swift
//  Vigo
//
//  Created by IREM SEVER on 13.02.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct TrendingCell: View, ScrollingHelper {
    @ObservedObject var viewModel: ExploreViewModel
    @State private var selectedIndex: Int = 1
    @State private var scrollProxy: ScrollViewProxy?
    @State private var isExpanded = false
    @State var scrollOffset: CGFloat = 0
    @State private var selectedCategory: CategoryType = .trending
    
    @State private var scrollProgressX: CGFloat = 0
    @State private var scrollOffsetY: CGFloat = 0
    @State private var isUser: Bool = false
    
    
    private var loopingData: [ExploreNews] {
        guard let exploreData = viewModel.exploreModel?.data else { return [] }
        let allNewsItems = exploreData.flatMap { $0.news ?? [] }
        guard allNewsItems.count > 1 else { return allNewsItems }
        return [allNewsItems.last!] + allNewsItems + [allNewsItems.first!]
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{   if !loopingData.isEmpty {
                let selectedItem = loopingData[selectedIndex]
                if let imageUrl = selectedItem.image, let validUrl = URL(string: imageUrl) {
                    WebImage(url: validUrl)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    
                        .blur(radius: 30, opaque: true)
                        .overlay {
                            Rectangle().fill(Color.black.opacity(0.35))
                        }
                        .mask {
                            LinearGradient(gradient: Gradient(colors: [
                                .black, .gray, .gray, .gray, .white.opacity(0.5), .clear
                            ]), startPoint: .top, endPoint: .bottom)
                        }.ignoresSafeArea(.all)
                        .opacity(0.7)
                }
                ScrollView(showsIndicators: false) {
                    ZStack {
                        ScrollView(.vertical, showsIndicators: false) {
                            ScrollOffsetBg { offset in
                                self.scrollOffset = offset - geometry
                                    .safeAreaInsets.top
                            }
                            .frame(height: 0)
                            VStack {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    ScrollViewReader { proxy in
                                        HStack {
                                            ForEach(loopingData.indices, id: \.self) { index in
                                                let newsItem = loopingData[index]
                                                let size = getSizeForIndex(index, selectedIndex: selectedIndex)
                                                
                                                VStack {
                                                    if selectedIndex == index {
                                                        if !isExpanded {
                                                            VStack {
                                                                Text(newsItem.title ?? "")
                                                                    .font(.exoBold(size: selectedIndex == index ? 28 : 15))
                                                                    .foregroundColor(selectedIndex == index ? .orange : .purple.opacity(0.8))
                                                                    .lineLimit(2)
                                                                    .padding(.bottom, 8)
                                                                if selectedIndex == index {
                                                                    Text(newsItem.spot ?? "")
                                                                        .font(.exoMedium(size: 12))
                                                                        .foregroundColor(.white)
                                                                        .lineLimit(3)
                                                                        .padding(.bottom, 8)
                                                                        .frame(width: 250, alignment: .center)
                                                                        .multilineTextAlignment(.center)
                                                                }
                                                                if let tags = newsItem.tags, !tags.isEmpty {
                                                                    HStack {
                                                                        ForEach(tags, id: \.title) { tag in
                                                                            TagViewOrange(text: tag.title ?? "")
                                                                        }
                                                                    }
                                                                    .padding(.top, 8)
                                                                }
                                                                
                                                                HStack(spacing: 10) {
                                                                    ZStack {
                                                                        SwiftUI.Image("romanleaves")
                                                                            .resizable()
                                                                            .aspectRatio(contentMode: .fill)
                                                                            .frame(width: 40, height: 35)
                                                                            .opacity(0.3)
                                                                        VStack{
                                                                            Text(newsItem.imdb ?? "")
                                                                                .font(.exoSemiBold(size: 14))
                                                                                .foregroundColor(.white.opacity(0.8))
                                                                            
                                                                            Text("IMDb")
                                                                                .font(.exoMedium(size: 14))
                                                                                .foregroundColor(.white.opacity(0.8))
                                                                        }
                                                                    }  .frame(width: 60, alignment: .center)
                                                                    ZStack {
                                                                        
                                                                        SwiftUI.Image("favorite")
                                                                            .resizable()
                                                                            .aspectRatio(contentMode: .fill)
                                                                            .frame(width: 30, height: 30)
                                                               
                                                                            .opacity(0.2)
                                                                           
                                                                        VStack {
                                                                            Text(newsItem.liked ?? "")
                                                                                .font(.exoSemiBold(size: 14))
                                                                                .foregroundColor(.white.opacity(0.8))
                                                                            Text("Liked")
                                                                                .font(.exoMedium(size: 14))
                                                                                .foregroundColor(.white.opacity(0.8))
                                                                        }
                                                                    } .frame(width: 60, alignment: .center)
                                                                    
                                                                    ZStack {
                                                                        SwiftUI.Image(systemName: "play")
                                                                            .resizable()
                                                                            .aspectRatio(contentMode: .fill)
                                                                            .frame(width: 20, height: 20)
                                                                            .foregroundColor(.gray.opacity(0.2))
                                                                            .fontWeight(.light)
                                                                     
                                                                        VStack {
                                                                            Text(newsItem.duration ?? "")
                                                                                .font(.exoSemiBold(size: 14))
                                                                                .foregroundColor(.white.opacity(0.8))
                                                                            Text("Duration")
                                                                                .font(.exoMedium(size: 14))
                                                                                .foregroundColor(.white.opacity(0.8))
                                                                        }
                                                                    } .frame(width: 60, alignment: .center)
                                                                    //                                                                    }
                                                                    
                                                                } .frame(width: 200)
                                                                    .padding(.bottom, 30)
                                                                    .padding(.top, 10)
                                                            }
                                                            .frame(width: 350, height: 350)
                                                            .background(
                                                                RoundedRectangle(cornerRadius: 175)
                                                                    .fill(Color.black.opacity(0.1))
                                                                    .shadow(
                                                                        color: selectedIndex == index ? .orange.opacity(0.9) : .purple.opacity(0),
                                                                        radius: selectedIndex == index ? 100 : 0)
                                                            )
                                                            .overlay(
                                                                RoundedRectangle(cornerRadius: 175)
                                                                    .stroke(Color.orange.opacity(0.3), lineWidth: 3)
                                                            )
                                                            .padding(.top, 120)
                                                            .padding(.bottom, -80)
                                                        }
                                                    }
                                                    if let imageUrl = newsItem.image, let validUrl = URL(string: imageUrl) {
                                                        WebImage(url: validUrl)
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(width: isExpanded ? size / 1.5 : size * 1.2, height: isExpanded ? size / 1.5 : size * 1.2)
                                                            .clipShape(Circle())
                                                            .overlay(
                                                                Circle()
                                                                    .stroke(selectedIndex == index ? Color.orange.opacity(0.4) : Color.purple.opacity(0.3), lineWidth: 4)
                                                                    .shadow(color: selectedIndex == index ? .orange.opacity(0.6) : .purple.opacity(0.3), radius: 4, x: 2, y: 2)
                                                            )
                                                            .background(
                                                                Circle()
                                                                    .fill(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.2), Color.black.opacity(0.1)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                                                    .shadow(color: .black.opacity(0.15), radius: 10, x: -5, y: -5)
                                                            )
                                                            .overlay(
                                                                Circle()
                                                                    .stroke(Color.white.opacity(0.8), lineWidth: 1)
                                                                    .blur(radius: 5)
                                                            )
                                                            .opacity(selectedIndex == index ? 1 : 0.85)
                                                            .shadow(
                                                                color: selectedIndex == index ? .orange.opacity(0.45) : .purple.opacity(0.2),
                                                                radius: selectedIndex == index ? (isExpanded ? 12 : 18) : 12
                                                            )
                                                    }

                                                    if isExpanded {
                                                        Text(newsItem.title ?? "")
                                                            .font(.exoBold(size: selectedIndex == index ? 24 : 15))
                                                            .foregroundColor(selectedIndex == index ? .orange : .purple.opacity(0.8))
                                                            .lineLimit(2)
                                                            .padding(.bottom, 8)
                                                        
                                                        if selectedIndex == index {
                                                            Text(newsItem.spot ?? "")
                                                                .font(.exoSemiBold(size: 14))
                                                                .foregroundColor(.white)
                                                                .padding(.bottom, 8)
                                                                .lineLimit(8)
                                                                .multilineTextAlignment(.center)
                                                        }
                                                    }
                                                }
                                                .frame(width: 220)
                                                .offset(y: (selectedIndex == index ? (isExpanded ? -65 : -220) : 50))
                                                .frame(
                                                    width: selectedIndex == index ? 250 : 150,
                                                    height: isExpanded ? 430 : 670,
                                                    alignment: .center
                                                )
                                                
                                            }
                                        }
                                        .padding(.horizontal)
                                        .frame(minWidth: geometry.size.width, alignment: .center)
                                        .onAppear {
                                            scrollProxy = proxy
                                            scrollToIndex(selectedIndex, proxy: scrollProxy)
                                        }
                                        .offset(y: isExpanded ? 100 : 180)
                                    }
                                }
                                .disabled(true)
                                
                                Button(action: {
                                    withAnimation {
                                        isExpanded.toggle()
                                    }
                                }) {
                                    SwiftUI.Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                                        .font(.headline).bold()
                                        .frame(width: 30, height: 30, alignment: .center)
                                        .foregroundColor(.orange)
                                }.padding(.bottom, 20)
                                
                                if isExpanded {
                                    VStack {
                                        Text("Videos")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .font(.exoBold(size: 18))
                                            .padding(.horizontal, 16)
                                            .foregroundColor(.orange)
                                        
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            
                                            HStack {
                                                if let exploreVideos = loopingData[selectedIndex].exploreVideos {
                                                    ForEach(exploreVideos, id: \.id) { video in
                                                        VStack {
                                                            if let imageUrl = video.image, let validUrl = URL(string: imageUrl) {
                                                                WebImage(url: validUrl)
                                                                    .resizable()
                                                                    .aspectRatio(contentMode: .fill)
                                                                    .frame(width: 150, height: 100)
                                                                    .cornerRadius(10)
                                                                    .shadow(color: .purple.opacity(0.35), radius: 2)
                                                            }
                                                     
                                                            
                                                            Text(video.spot ?? "")
                                                                .font(.exoMedium(size: 12))
                                                                .foregroundColor(.white)
                                                                .lineLimit(1)
                                                                .padding(.horizontal, 4)
                                                            
                                                        }
                                                    }
                                                }
                                            }
                                            .padding(.horizontal, 16)
                                            .padding(.bottom, 16)
                                        }
                                        
                                        Text("Cast")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .font(.exoBold(size: 18))
                                            .padding(.horizontal, 16)
                                            .foregroundColor(.orange)
                                        
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack {
                                                if let artists = loopingData[selectedIndex].artists {
                                                    ForEach(artists, id: \.title) { artist in
                                                        VStack {
                                                            if let imageUrl = artist.image, let validUrl = URL(string: imageUrl) {
                                                                WebImage(url: validUrl)
                                                                    .resizable()
                                                                    .aspectRatio(contentMode: .fill)
                                                                    .frame(width: 80, height: 80)
                                                                    .cornerRadius(45)
                                                                    .shadow(color: .purple.opacity(0.35), radius: 2)
                                                            }
                                                            Text(artist.title ?? "")
                                                                .font(.exoMedium(size: 12))
                                                                .foregroundColor(.white)
                                                                .frame(width: 90)
                                                                .lineLimit(1)
                                                                .padding(.horizontal, 4)
                                      
                                                            
                                                        }
                                                    }
                                                }
                                            }
                                            .padding(.bottom, 16)
                                            .padding(.horizontal, 16)
                                        }
                                        
                                        Text("Recommended")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .font(.exoBold(size: 18))
                                            .padding(.horizontal, 16)
                                            .foregroundColor(.orange)
                                        
                                        
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack {
                                                let recommendedShows = loopingData.filter { show in
                                                    guard let selectedTags = selectedItem.tags else { return false }
                                                    guard let showTags = show.tags else { return false }
                                                    
                                                    let selectedTagTitles = selectedTags.compactMap { $0.title }
                                                    let showTagTitles = showTags.compactMap { $0.title }
                                                    
                                                    return selectedTagTitles.contains { showTagTitles.contains($0) }
                                                }
                                                    .filter { $0.title != selectedItem.title }
                                                
                                                
                                                ForEach(recommendedShows, id: \.title) { recommendedShow in
                                                    VStack {
                                                        
                                                        if let imageUrl = recommendedShow.image, let validUrl = URL(string: imageUrl) {
                                                            WebImage(url: validUrl)
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fill)
                                                                .frame(width: 100, height: 150)
                                                                .cornerRadius(20)
                                                                .shadow(color: .purple.opacity(0.35), radius: 2)
                                                        }
                                                        Text(recommendedShow.title ?? "")
                                                            .font(.exoMedium(size: 12))
                                                            .foregroundColor(.white)
                                                            .frame(width: 110)
                                                            .lineLimit(1)
                                                    }
                                                }
                                                
                                            }
                                            .padding(.horizontal, 15)
                                            .padding(.bottom, 110)
                                        }
                                    }
                                    .padding(.top, -20)
                                    .padding(.bottom, 50)
                                }
                            }
                        }
                    }
                }
            } }
            .gesture(
                DragGesture()
                    .onEnded { value in
                        let threshold: CGFloat = 50
                        withAnimation {
                            if value.translation.width < -threshold {
                                selectedIndex += 1
                            } else if value.translation.width > threshold {
                                selectedIndex -= 1
                            }
                            if selectedIndex == loopingData.count - 1 {
                                selectedIndex = 1
                            } else if selectedIndex == 0 {
                                selectedIndex = loopingData.count - 2
                            }
                            scrollToIndex(selectedIndex, proxy: scrollProxy)
                        }
                    }
            )
            .overlay {
                SectionHeader(selectedCategory: $selectedCategory,
                              categories: CategoryType.allCases,
                              isExplore: true,
                              onCategorySelected: { selectedCategory in
                    viewModel.fetchExploreData(for: selectedCategory) {}
                }, scrollOffset: $scrollOffset)
                .padding(.top, 20)
                .zIndex(1)
                
            }
            
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background {
                Rectangle()
                    .fill(.black.gradient)
                    .scaleEffect(y: -1)
                    .ignoresSafeArea(edges: .all)
            }
            .safeAreaInset(edge: .top, content: {
                Color.clear.frame(height: 40)
            })
        }
    }
}
