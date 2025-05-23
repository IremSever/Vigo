//
//  FavoritesListView.swift
//  Vigo
//
//  Created by IREM SEVER on 25.03.2025.
//


import SwiftUI
import SDWebImageSwiftUI

struct FavoritesListView: View {
    let viewModel: FavoritesViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Favorites")
                .foregroundColor(.white)
                .font(.exoBold(size: 18))
                .padding(.horizontal, 16)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(viewModel.favoriteItems, id: \ .title) { item in
                        if let imageUrl = URL(string: item.image ?? "") {
                            VStack {
                            WebImage(url: imageUrl)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 160, height: 120)
                                .cornerRadius(15)
                         
                                Text(item.title ?? "")
                                    .font(.exoSemiBold(size: 14))
                                    .foregroundColor(.orange)
                                    .frame(width: 150)
                                    .lineLimit(1)
                            }
                        }
                    }
                }
                .padding(.horizontal, 12)
            }
        }
    }
}
