//
//  CoinTabView.swift
//  MiniCoinProject
//
//  Created by 김상규 on 9/9/24.
//

import SwiftUI

struct CoinTabView: View {
    @State private var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            
            CoinTrendingView()
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                }
                .tag(1)
            
            CoinSearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .tag(2)
            
            CoinFavoriteView()
                .tabItem {
                    Image(systemName: "star")
                }
                .tag(3)
            
            Text("MyPageView")
                .tabItem {
                    Image(systemName: "person.fill")
                }
                .tag(4)
        }
    }
}

#Preview {
    CoinTabView()
}
