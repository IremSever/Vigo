//
//  AchiveCell.swift
//  Vigo
//
//  Created by İrem Sever on 9.02.2025.
//

import SwiftUI
import SDWebImageSwiftUI
struct AchiveCell: View {
    @ObservedObject var viewModel: HomeViewModel
      var widgetTitle: String?
      
      @State private var currentIndex = 1
      @State private var scrollProgressX: CGFloat = 0
      @State private var scrollOffsetY: CGFloat = 0
      
      var body: some View {
          ScrollView(.horizontal, showsIndicators: false) {
              HStack(spacing: -30) {
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
                      
                      let urlNewsItems = newsItems.filter { newsItem in
                          return newsItem.external.starts(with: "external://https:")
                      }
                      
                   
                      
                      ForEach(urlNewsItems.indices, id: \ .self) { index in
                          let newsItem = urlNewsItems[index]
                          
                          NavigationLink(destination: DetailVC(viewModel: viewModel, selectedIndex: index, widgetTitle: widgetTitle ?? "")) {
                              VStack {
                                  if let imageUrl = URL(string: newsItem.image ?? "") {
                                      WebImage(url: imageUrl)
                                          .resizable()
                                          .aspectRatio(contentMode: .fill)
                                          .frame(width: index == currentIndex ? 200 : 150, height: 300)
                                          .cornerRadius(20)
                                          .shadow(color: .black.opacity(0.4), radius: 5, x: 5, y: 5)
                                          .rotationEffect(.degrees(index == currentIndex ? 0 : (index < currentIndex ? -10 : 10)))
                                          .offset(y: index == currentIndex ? -10 : 20)
                                          .animation(.spring(), value: currentIndex)
                                  }
                                  
                                  VStack(alignment: .center, spacing: 5) {
                                      Text(newsItem.title)
                                          .font(.headline)
                                          .foregroundColor(.white)
                                          .multilineTextAlignment(.center)
                                          .padding(.top, 8)
                                      
                                      if let spot = newsItem.spot {
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
              }
          }
          .frame(height: 400)
          .background(.clear)
          .onChange(of: scrollProgressX) { newIndex in
              currentIndex = Int(newIndex.rounded())
          }
      }
  }
