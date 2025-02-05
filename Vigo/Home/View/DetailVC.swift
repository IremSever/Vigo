//
//  DetailVC.swift
//  Vigo
//
//  Created by İrem Sever on 3.02.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailVC: View {
    @ObservedObject var viewModel: HomeViewModel
    var selectedIndex: Int
    
    var body: some View {
        VStack {
            if let homeData = viewModel.homeModel?.data, !homeData.isEmpty {
                let validData = homeData.filter { $0.news?.first?.image != nil }
                
                if selectedIndex < validData.count {
                    let item = validData[selectedIndex]
                    Text(item.news?.first?.title ?? "No Title")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    
                    if let imageUrl = item.news?.first?.image,
                       let url = URL(string: imageUrl) {
                        WebImage(url: url)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 300)
                            .padding()
                    }
                } else {
                    Text("Invalid index")
                        .font(.title)
                        .padding()
                }
            } else {
                Text("Loading Data...")
                    .font(.title)
                    .padding()
            }
            
            Spacer()
        }
        .navigationTitle("Detail View")
        .onAppear {
            viewModel.fetchHomeData {
                
            }
        }
    }
}

//#Preview {
//    DetailVC()
//}

/*
import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailsView: View {
    var item: Movie
    
    @ObservedObject private var viewModel = MovieDetailsViewModel()
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack(alignment: .leading) {
                WebImage(url: URL(string: "\(Constants.imagesBaseUrl)\(item.backdrop_path ?? "")"))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                    .clipped()
                    .overlay(
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Button(action: {
                                    presentation.wrappedValue.dismiss()
                                }, label: {
                                    Image(systemName: "arrow.left")
                                        .font(.system(size: 32))
                                        .foregroundColor(Color("yellow"))
                                })
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.top, 40)
                            
                            Spacer()
                            
                            Text(item.title ?? "Loading...")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            
                            Text("\(viewModel.movie?.runtime ?? 0) min")
                                .font(.system(size: 15))
                                .foregroundColor(.gray)
                                .redacted(reason: viewModel.movie?.runtime == nil ? .placeholder : .init())
                                .padding(.horizontal)
                                
                            HStack(spacing: 8) {
                                ForEach(viewModel.movie?.genres ?? [Genre(id: 0, name: nil)], id: \.id) { genre in
                                    Text(genre.name ?? "Loading...")
                                        .font(.system(size: 15))
                                        .foregroundColor(.gray)
                                        .redacted(reason: genre.name == nil ? .placeholder : .init())
                                    
                                    Circle()
                                        .frame(width: 5, height: 5)
                                        .foregroundColor(Color("yellow"))
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.124825187, green: 0.1294132769, blue: 0.1380611062, alpha: 1)), Color.clear]), startPoint: .bottom, endPoint: .top))
                    )
                
                Text(viewModel.movie?.overview ?? "Loading...")
                    .foregroundColor(.gray)
                    .redacted(reason: viewModel.movie?.overview == nil ? .placeholder : .init())
                    .padding()
                
                Spacer()
            }
        })
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .background(Color("background"))
        .ignoresSafeArea(.all, edges: .all)
        .onAppear {
            viewModel.fetchData(id: item.id!)
        }
    }
}*/
