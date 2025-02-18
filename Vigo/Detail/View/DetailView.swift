//
//  DetailVC.swift
//  Vigo
//
//  Created by İrem Sever on 3.02.2025.
//
import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let detailModel = viewModel.detailModel {
                    
                    if let firstData = detailModel.data.first {
                        
     
                        if let imageUrlString = firstData.singleImage?.src, let imageUrl = URL(string: imageUrlString) {
                            AsyncImage(url: imageUrl) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(maxWidth: .infinity, maxHeight: 500)
                        }
                        if let description = firstData.description?.description {
                            Text(description)
                                .font(.body)
                                .foregroundColor(.gray)
                                
                                .padding()
                        }
                    }
                }
            }
        }.padding()
    }
}

//}
//
//import SwiftUI
//import SDWebImageSwiftUI
//
//struct DetailView: View {
//    @ObservedObject var viewModel: HomeViewModel
//    var selectedIndex: Int
//    var widgetTitle: String
//    @Environment(\.dismiss) private var dismiss
//    
//    var body: some View {
//        ZStack {
//            Color.black.edgesIgnoringSafeArea(.all)
//            
//            VStack(alignment: .leading, spacing: 16) {
//                if let homeData = viewModel.homeModel?.data, !homeData.isEmpty {
//                    let filteredSections = homeData.filter { $0.config.widgetTitle?.text == widgetTitle }
//                    let newsItems = filteredSections.flatMap { $0.news ?? [] }
//                    
//                    if selectedIndex < newsItems.count {
//                        let item = newsItems[selectedIndex]
//                     
//                        ZStack(alignment: .topLeading) {
//                            if let imageUrl = item.image, let url = URL(string: imageUrl) {
//                                WebImage(url: url)
//                                    .resizable()
//                                    .scaledToFill()
//                                    .frame(height: 400)
//                                    .clipped()
//                            }
//                           
//                            Button(action: {
//                                dismiss()
//                            }) {
//                                SwiftUI.Image(systemName: "chevron.left")
//                                    .foregroundColor(.white)
//                                    .padding()
//                                    .background(Color.black.opacity(0.5))
//                                    .clipShape(Circle())
//                                    .padding(.top, 40)
//                                    .padding(.leading, 16)
//                            }
//                        }
//                        
//                       
//                        VStack(alignment: .leading, spacing: 8) {
//                            Text(item.title)
//                                .font(.largeTitle.bold())
//                                .foregroundColor(.white)
//                                .padding(.horizontal)
//                            
//                            if let spot = item.spot {
//                                Text(spot)
//                                    .font(.body)
//                                    .foregroundColor(.gray)
//                                    .padding(.horizontal)
//                            }
//                        }
//                        
//                    
//                        HStack(spacing: 16) {
//                            Button(action: {
//                    
//                            }) {
//                                Label("Play", systemImage: "play.fill")
//                                    .frame(maxWidth: .infinity)
//                                    .padding()
//                                    .background(Color.blue)
//                                    .foregroundColor(.white)
//                                    .cornerRadius(10)
//                            }
//                            
//                            Button(action: {
//
//                            }) {
//                                Label("Download", systemImage: "arrow.down.to.line")
//                                    .frame(maxWidth: .infinity)
//                                    .padding()
//                                    .background(Color.gray.opacity(0.2))
//                                    .foregroundColor(.white)
//                                    .cornerRadius(10)
//                            }
//                        }
//                        .padding(.horizontal)
//                        
//                        Spacer()
//                    } else {
//                        Text("Invalid index")
//                            .font(.title)
//                            .foregroundColor(.white)
//                            .padding()
//                    }
//                } else {
//                    Text("Loading Data...")
//                        .font(.title)
//                        .foregroundColor(.white)
//                        .padding()
//                }
//            }
//        }
//        .navigationBarBackButtonHidden(true)
//        .onAppear {
//            viewModel.fetchHomeData {}
//        }
//        .edgesIgnoringSafeArea(.top)
//        
//    }
//}
