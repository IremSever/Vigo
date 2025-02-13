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
                      
                   Spacer()
                      
                      ForEach(urlNewsItems.indices, id: \ .self) { index in
                          let newsItem = urlNewsItems[index]
                        
                              VStack {
                                  
                                  if let imageUrl = URL(string: newsItem.image ?? "") {
                                      WebImage(url: imageUrl)
                                          .resizable()
                                          .scaledToFill()
                                          .frame(width: index == currentIndex ? 150 : 120, height: 200)
                                          .cornerRadius(20)
                                          .shadow(color: .purple.opacity(0.4), radius: 3)
                                          .rotationEffect(.degrees(index == currentIndex ? 10 : (index < currentIndex ? -10 : 10)))
                                          .offset(y: index == currentIndex ? -10 : 10)
                                          .animation(.spring(), value: currentIndex)
                                      
                                  }
                                 
                              }
                          
                      }
                      Spacer()
                  }
              }
          .frame(height: 250)
          .background(.clear)
          .onChange(of: scrollProgressX) { newIndex in
              currentIndex = Int(newIndex.rounded())
          }
      }
  }
