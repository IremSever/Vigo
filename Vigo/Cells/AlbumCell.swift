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
    var widgetTitle: String?
    
    @State private var currentIndex = 1
    @State private var scrollProgressX: CGFloat = 0
    @State private var scrollOffsetY: CGFloat = 0
    @State private var topInset: CGFloat = 0
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                if let widgetTitle = widgetTitle {
                    Text(widgetTitle)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.horizontal)
                }
                
                if let homeData = viewModel.homeModel?.data {
                    let filteredSections = homeData.filter { $0.config.widgetTitle?.text == widgetTitle }
                    let newsItems = filteredSections.flatMap { $0.news ?? [] }
                    
                    let infiniteItems = [newsItems.last!] + newsItems + [newsItems.first!]
                 
                    ForEach(0..<infiniteItems.count, id: \..self) { index in
                        VStack{
                        if let imageUrl = URL(string: infiniteItems[index].image ?? "") {
                            WebImage(url: imageUrl)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 400)
                                .cornerRadius(12)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(color: .black.opacity(0.4), radius: 5, x: 5, y: 5)
                        }
                        VStack(alignment: .center, spacing: 5) {
                            Text(infiniteItems[index].title)
                                .font(.headline)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.top, 8)
                            if let spot = infiniteItems[index].spot {
                                Text(spot)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                            }
                        }
        
                    }
                    }
                }
                
            }

            .frame(height: 400)
            .background(Backdrop(images: viewModel.getBackdropImages(), scrollProgressX: $scrollProgressX, scrollOffsetY: $scrollOffsetY, topInset: $topInset))
            .scrollIndicators(.hidden)
            
        }
    }
}




//
//struct AlbumCell: View {
//    @ObservedObject var viewModel: HomeViewModel
//    var widgetTitle: String?
//
//    @State private var currentIndex = 1
//    
//    var body: some View {
//        LazyVStack(alignment: .leading, spacing: 0) {
//            if let widgetTitle = widgetTitle {
//                Text(widgetTitle)
//                    .font(.title2)
//                    .bold()
//                    .foregroundColor(.white)
//                    .padding(.horizontal)
//            }
//            
//            if let homeData = viewModel.homeModel?.data {
//                let filteredSections = homeData.filter { $0.config.widgetTitle?.text == widgetTitle }
//                let newsItems = filteredSections.flatMap { $0.news ?? [] }
//                
//                let infiniteItems = [newsItems.last!] + newsItems + [newsItems.first!]
//                
//                TabView(selection: $currentIndex) {
//                    ForEach(0..<infiniteItems.count, id: \.self) { index in
//                        GeometryReader { geometry in
//                            VStack {
//                                if let imageUrl = URL(string: infiniteItems[index].image ?? "") {
//                                    WebImage(url: imageUrl)
//                                        .resizable()
//                                        .scaledToFill()
//                                        .frame(width: geometry.size.width * 0.70, height: 400)
//                                        .cornerRadius(12)
//                                        .clipped()
//                                }
//                                VStack(alignment: .center, spacing: 5) {
//                                    Text(infiniteItems[index].title)
//                                        .font(.headline)
//                                        .foregroundColor(.white)
//                                        .multilineTextAlignment(.center)
//                                        .padding(.top, 8)
//                                    if let spot = infiniteItems[index].spot {
//                                        Text(spot)
//                                            .font(.subheadline)
//                                            .foregroundColor(.gray)
//                                            .multilineTextAlignment(.center)
//                                    }
//                                }
//                                .padding(.horizontal)
//                            }
//                            .frame(width: geometry.size.width)
//                            .tag(index)
//                        }
//                        .frame(width: UIScreen.main.bounds.width)
//                    }
//                }
//                .frame(height: 470)
//                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//                .onChange(of: currentIndex) { newIndex in
//                    if newIndex == 0 {
//                        currentIndex = infiniteItems.count - 2
//                    } else if newIndex == infiniteItems.count - 1 {
//                        currentIndex = 1
//                    }
//                }
//                .frame(width: UIScreen.main.bounds.width)
//            }
//        }
//        .background(Color.black.edgesIgnoringSafeArea(.all))
//    }
//}
