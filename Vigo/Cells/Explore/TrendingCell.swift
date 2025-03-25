//
//  TrendingCell.swift
//  Vigo
//
//  Created by IREM SEVER on 13.02.2025.
//
//import SwiftUI
//import SDWebImageSwiftUI
//
//struct TrendingCell: View, ScrollingHelper {
//    @ObservedObject var viewModel: ExploreViewModel
//    @State private var selectedIndex: Int = 1
//    @State private var scrollProxy: ScrollViewProxy?
//    @State private var isExpanded = false
//    @State var scrollOffset: CGFloat = 0
//    @State private var selectedCategory: CategoryType = .trending
//    
//    private var loopingData: [ExploreNews] {
//        guard let exploreData = viewModel.exploreModel?.data else { return [] }
//        let allNewsItems = exploreData.flatMap { $0.news ?? [] }
//        guard allNewsItems.count > 1 else { return allNewsItems }
//        return [allNewsItems.last!] + allNewsItems + [allNewsItems.first!]
//    }
//
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack{   if !loopingData.isEmpty {
//                let selectedItem = loopingData[selectedIndex]
//                
//                if let imageUrl = selectedItem.image, let validUrl = URL(string: imageUrl) {
//                    WebImage(url: validUrl)
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: geometry.size.width, height: geometry.size.height)
//                        .clipped()
//                        .blur(radius: 30, opaque: true)
//                        .overlay {
//                            Rectangle().fill(Color.black.opacity(0.35))
//                        }
//                        .mask {
//                            LinearGradient(gradient: Gradient(colors: [
//                                .black, .gray, .gray, .gray, .white.opacity(0.5), .clear
//                            ]), startPoint: .top, endPoint: .bottom)
//                        }.ignoresSafeArea(.all)
//                        .opacity(0.7)
//                }
//                
//                ScrollView(showsIndicators: false) {
//                    ZStack {
//                        
//                        ScrollView(.vertical, showsIndicators: false) {
//                            ScrollOffsetBg { offset in
//                                self.scrollOffset = offset - geometry
//                                    .safeAreaInsets.top
//                            }
//                            .frame(height: 0)
//                            VStack {
//                                ScrollView(.horizontal, showsIndicators: false) {
//                                    ScrollViewReader { proxy in
//                                        HStack {
//                                            ForEach(loopingData.indices, id: \.self) { index in
//                                                let newsItem = loopingData[index]
//                                                let size = getSizeForIndex(index, selectedIndex: selectedIndex)
//                                                
//                                                VStack {
//                                                    if let imageUrl = newsItem.image, let validUrl = URL(string: imageUrl) {
//                                                        WebImage(url: validUrl)
//                                                            .resizable()
//                                                            .aspectRatio(contentMode: .fill)
//                                                            .frame(width: isExpanded ? size / 2 : size, height: isExpanded ? size / 2 : size )
//                                                            .clipShape(Circle())
//                                                            .overlay(
//                                                                Circle()
//                                                                    .stroke(selectedIndex == index ? Color.orange.opacity(0.2) : Color.purple.opacity(0.2), lineWidth: 3)
//                                                                    .shadow(color: selectedIndex == index ? .orange : .purple, radius: selectedIndex == index ? 3 : 1)
//                                                            )
//                                                            .opacity(selectedIndex == index ? 1 : 0.8)
//                                                    }
//                                                    
//                                                    Text(newsItem.title ?? "")
//                                                        .font(.exoBold(size: selectedIndex == index ? 24 : 15))
//                                                        .foregroundColor(selectedIndex == index ? .orange : .purple.opacity(0.8))
//                                                        .lineLimit(2)
//                                                        .padding(.bottom, 8)
//                                                    
//                                                    if selectedIndex == index {
//                                                        JustifiedText(
//                                                            newsItem.spot ?? "",
//                                                            isExpanded: $isExpanded,
//                                                            font: UIFont(name: "Exo2-SemiBold", size: 14) ?? UIFont.systemFont(ofSize: 14)
//                                                        )
//                                                        .frame(maxWidth: .infinity)
//                                                    }
//                                                }
//                                                .frame(width: 220)
//                                                
//                                                .frame(
//                                                    width: selectedIndex == index ? 250 : 150,
//                                                    height: isExpanded ? 515 : 600,
//                                                    alignment: .center
//                                                )
//                                                
//                                             
//                                            }
//                                        }
//                                        .padding(.horizontal)
//                                        .frame(minWidth: geometry.size.width, alignment: .center)
//                                        .onAppear {
//                                            scrollProxy = proxy
//                                            scrollToIndex(selectedIndex, proxy: scrollProxy)
//                                        }
//                                        .offset(y: isExpanded ? 50 : 120)
//                                    }
//                                }
//                                .disabled(true)
//                                
//                                
//                                Button(action: {
//                                    withAnimation {
//                                        isExpanded.toggle()
//                                    }
//                                }) {
//                                    SwiftUI.Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
//                                        .font(.headline).bold()
//                                        .frame(width: 30, height: 30, alignment: .center)
//                                        .foregroundColor(.orange)
//                                }.padding(.bottom, 20)
//
//                                if isExpanded {
//                                    VStack {
//                                       ZStack {
//                                            Spacer()
//                                            Text("Videos")
//                                                .font(.exoBold(size: 18))
//                                                .padding(.horizontal, 16)
//                                                .foregroundColor(.orange)
//                                            Spacer()
//                                           HStack {
//                                               Spacer()
//                                               
//                                               Button(action: {}) {
//                                                   //SwiftUI.Image(systemName: "chevron.right")
////                                                   Text("Show All")
////                                                       .font(.exoMedium(size: 14))
////                                                       .foregroundColor(.purple)
////                                                       .multilineTextAlignment(.trailing)
//                                                   
//                                               }
//                                           }
//                                           .padding(.trailing, 16)
//                                        }
//                                        ScrollView(.horizontal, showsIndicators: false) {
//                                            
//                                            HStack {
//                                                if let exploreVideos = loopingData[selectedIndex].exploreVideos {
//                                                    ForEach(exploreVideos, id: \.id) { video in
//                                                        VStack {
//                                                            if let imageUrl = video.image, let validUrl = URL(string: imageUrl) {
//                                                                WebImage(url: validUrl)
//                                                                    .resizable()
//                                                                    .aspectRatio(contentMode: .fill)
//                                                                    .frame(width: 150, height: 100)
//                                                                    .cornerRadius(10)
//                                                                    .shadow(color: .purple.opacity(0.35), radius: 2)
//                                                            }
//                                                            Text(video.title ?? "")
//                                                                .font(.exoSemiBold(size: 14))
//                                                                .foregroundColor(.orange)
//                                                                .lineLimit(1)
//                                                            
//                                                            Text(video.spot ?? "")
//                                                                .font(.exoMedium(size: 12))
//                                                                .foregroundColor(.white)
//                                                                .lineLimit(1)
//                                                                .padding(.horizontal, 4)
//                                                            
//                                                        }
//                                                    }
//                                                }
//                                            }
//                                            .padding(.horizontal, 16)
//                                            .padding(.bottom, 16)
//                                        }
//                                        
//                                        Text("Cast")
//                                            .font(.exoBold(size: 18))
//                                            .padding(.horizontal, 16)
//                                            .foregroundColor(.orange)
//                                        
//                                        ScrollView(.horizontal, showsIndicators: false) {
//                                            HStack {
//                                                if let artists = loopingData[selectedIndex].artists {
//                                                    ForEach(artists, id: \.title) { artist in
//                                                        VStack {
//                                                            if let imageUrl = artist.image, let validUrl = URL(string: imageUrl) {
//                                                                WebImage(url: validUrl)
//                                                                    .resizable()
//                                                                    .aspectRatio(contentMode: .fill)
//                                                                    .frame(width: 80, height: 80)
//                                                                    .cornerRadius(45)
//                                                                    .shadow(color: .purple.opacity(0.35), radius: 2)
//                                                            }
//                                                            Text(artist.title ?? "")
//                                                                .font(.exoSemiBold(size: 14))
//                                                                .foregroundColor(.orange)
//                                                                .frame(width: 90)
//                                                                .lineLimit(1)
//                                                        
//                                                            Text(artist.spot ?? "")
//                                                                .font(.exoMedium(size: 12))
//                                                                .foregroundColor(.white)
//                                                                .frame(width: 90)
//                                                                .lineLimit(1)
//                                                                .padding(.horizontal, 4)
//                                                            
//                                                        }
//                                                    }
//                                                }
//                                            }
//                                            .padding(.bottom, 16)
//                                            .padding(.horizontal, 16)
//                                        }
//                                        
//                                        Text("Recommended")
//                                            .font(.exoBold(size: 18))
//                                            .padding(.horizontal, 16)
//                                            .foregroundColor(.orange)
//                                        
//                                        ScrollView(.horizontal, showsIndicators: false) {
//                                            HStack {
//                                                
//                                                let recommendedShows = loopingData.filter { show in
//                                                    guard let selectedTags = selectedItem.tags else { return false }
//                                                    guard let showTags = show.tags else { return false }
//                                                    
//                                                    let selectedTagTitles = selectedTags.compactMap { $0.title }
//                                                    let showTagTitles = showTags.compactMap { $0.title }
//                                                    
//                                                    return selectedTagTitles.contains { showTagTitles.contains($0) }
//                                                }
//                                                .filter { $0.title != selectedItem.title }
//                                                 
//                                                    
//                                                ForEach(recommendedShows, id: \.title) { recommendedShow in
//                                                    VStack {
//                                                        
//                                                        if let imageUrl = recommendedShow.image, let validUrl = URL(string: imageUrl) {
//                                                            WebImage(url: validUrl)
//                                                                .resizable()
//                                                                .aspectRatio(contentMode: .fill)
//                                                                .frame(width: 100, height: 150)
//                                                                .cornerRadius(20)
//                                                                .shadow(color: .purple.opacity(0.35), radius: 2)
//                                                        }
//                                                        Text(recommendedShow.title ?? "")
//                                                            .font(.exoMedium(size: 12))
//                                                            .foregroundColor(.white)
//                                                            .frame(width: 110)
//                                                            .lineLimit(1)
//                                                    }
//                                                }
//                                                
//                                            }
//                                            .padding(.horizontal, 16)
//                                            .padding(.bottom, 110)
//                                        }
//                                    }
//                                    .padding(.top, -20)
//                                    .padding(.bottom, 50)
//                                }
//                            }
//                        }
//                    }
//                }
//            } }
//            .gesture(
//                DragGesture()
//                    .onEnded { value in
//                        let threshold: CGFloat = 50
//                        withAnimation {
//                            if value.translation.width < -threshold {
//                                selectedIndex += 1
//                            } else if value.translation.width > threshold {
//                                selectedIndex -= 1
//                            }
//                            if selectedIndex == loopingData.count - 1 {
//                                selectedIndex = 1
//                            } else if selectedIndex == 0 {
//                                selectedIndex = loopingData.count - 2
//                            }
//                            scrollToIndex(selectedIndex, proxy: scrollProxy)
//                        }
//                    }
//            )
//            .overlay {
//                SectionHeader(selectedCategory: $selectedCategory,
//                              categories: CategoryType.allCases,
//                              isExplore: true,
//                              onCategorySelected: { selectedCategory in
//                    viewModel.fetchExploreData(for: selectedCategory) {}
//                }, scrollOffset: $scrollOffset)
//                .padding(.top, 20)
//                .zIndex(1)
//                
//            }
//            
//            .frame(width: geometry.size.width, height: geometry.size.height)
//            .background {
//                Rectangle()
//                    .fill(.black.gradient)
//                    .scaleEffect(y: -1)
//                    .ignoresSafeArea(edges: .all)
//            }
//            .safeAreaInset(edge: .top, content: {
//                Color.clear.frame(height: 40)
//            })
//        
//        }
//    }
//}



import SwiftUI
import SDWebImageSwiftUI

struct TrendingCell: View, ScrollingHelper {
    @ObservedObject var viewModel: ExploreViewModel
    @State private var selectedIndex: Int = 1
    @State private var scrollProxy: ScrollViewProxy?
    @State private var isExpanded = false
    @State var scrollOffset: CGFloat = 0
    @State private var selectedCategory: CategoryType = .trending
    
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
                        .clipped()
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
//                                                let size = getSizeForIndex(index, selectedIndex: selectedIndex)
                                                
                                                VStack {
                                                    if let imageUrl = newsItem.image, let validUrl = URL(string: imageUrl) {
                                                        WebImage(url: validUrl)
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(width: 200, height: 300)
                                                            .cornerRadius(20)
                                                            .clipped()
                                                            .overlay(
                                                                RoundedRectangle(cornerRadius: 20)
                                                                    .stroke(selectedIndex == index ? Color.orange.opacity(0.2) : Color.purple.opacity(0.2), lineWidth: 3)
                                                                    .shadow(color: selectedIndex == index ? .orange : .purple, radius: selectedIndex == index ? 3 : 1)
                                                            )
                                                            .opacity(selectedIndex == index ? 1 : 0.8)
                                                    }
                                                    
                                                    Text(newsItem.title ?? "")
                                                        .font(.exoBold(size: selectedIndex == index ? 24 : 15))
                                                        .foregroundColor(selectedIndex == index ? .orange : .purple.opacity(0.8))
                                                        .lineLimit(2)
                                                        .padding(.bottom, 8)
                                                    
                                                    if selectedIndex == index {
                                                        Text(newsItem.spot ?? "")
                                                            .font(.exoSemiBold(size: 14))
                                                            .foregroundColor( .white)
                                                            .padding(.bottom, 8)
                                                            .multilineTextAlignment(.center)
                                                            
                                                        
                                                    }
                                                }
                                                .frame(width: 220)
                                                
                                                .frame(
                                                    width: selectedIndex == index ? 250 : 150,
                                                    height: isExpanded ? 515 : 600,
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
                                        .offset(y: isExpanded ? 50 : 120)
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
                                       ZStack {
                                            Spacer()
                                            Text("Videos")
                                                .font(.exoBold(size: 18))
                                                .padding(.horizontal, 16)
                                                .foregroundColor(.orange)
                                            Spacer()
                                           HStack {
                                               Spacer()
                                               
                                               Button(action: {}) {
                                                   //SwiftUI.Image(systemName: "chevron.right")
//                                                   Text("Show All")
//                                                       .font(.exoMedium(size: 14))
//                                                       .foregroundColor(.purple)
//                                                       .multilineTextAlignment(.trailing)
                                                   
                                               }
                                           }
                                           .padding(.trailing, 16)
                                        }
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
                                                            Text(video.title ?? "")
                                                                .font(.exoSemiBold(size: 14))
                                                                .foregroundColor(.orange)
                                                                .lineLimit(1)
                                                            
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
                                                                .font(.exoSemiBold(size: 14))
                                                                .foregroundColor(.orange)
                                                                .frame(width: 90)
                                                                .lineLimit(1)
                                                        
                                                            Text(artist.spot ?? "")
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
                                            .padding(.horizontal, 16)
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
