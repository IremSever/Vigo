//
//  RatedView.swift
//  Vigo
//
//  Created by IREM SEVER on 25.03.2025.
//



import SwiftUI
import SDWebImageSwiftUI
struct RatedView: View {
    let viewModel: FavoritesViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Rated")
                .foregroundColor(.white)
                .font(.exoBold(size: 18))
                .padding(.horizontal, 16)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(viewModel.ratings.keys.sorted(), id: \ .self) { key in
                        if let item = viewModel.favoriteItems.first(where: { $0.title == key }),
                           let imageUrl = URL(string: item.image ?? ""),
                           let rating = viewModel.ratings[key] {
                            ImageCardView(imageUrl: imageUrl, rating: Double(rating))
                        }
                    }
                }
                .padding(.horizontal, 16)
                .frame(height: 235)
            }
        }
    }
}
