//
//  HomeVC.swift
//  Vigo
//
//  Created by İrem Sever on 31.01.2025.

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
        CustomNav(title: "Home", icon: "house") {
            LazyVStack(alignment: .leading) {
                if let homeData = viewModel.homeModel?.data {
                    ForEach(homeData.indices, id: \.self) { index in
                        if let widgetTitle = viewModel.homeModel?.data[index].config.widgetTitle?.text, !widgetTitle.isEmpty {
                            let formattedTitle = NSString(string: widgetTitle)
                                .lowercased(with: Locale(identifier: "tr_TR"))
                                .replacingOccurrences(of: "i", with: "İ")
                                .replacingOccurrences(of: "ı", with: "I")
                                .capitalized(with: Locale(identifier: "tr_TR"))

                            Text(formattedTitle)
                                .font(.system(size: 18).bold())
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .padding(.top)
                                .frame(height: 20)
                        }

                        RowView(viewModel: viewModel, index: index)
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        
    }.onAppear {
            viewModel.fetchHomeData {}
        }
    }
}
