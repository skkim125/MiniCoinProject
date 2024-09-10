//
//  CoinSearchView.swift
//  MiniCoinProject
//
//  Created by 김상규 on 9/9/24.
//

import SwiftUI

struct CoinSearchView: View {
    private let coingeckoManager = CoingeckoManager.shared
    @State private var search = ""
    @State private var coins: [Coin] = []
    @State private var myCoins: [Coin] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach($coins, id: \.id) { $coin in
                    NavigationLink {
                        NavigationWrapper(CoinDetailView(coin: $coin))
                    } label: {
                        CoinSearchRowView(coin: $coin, myCoins: $myCoins)
                    }
                }
                .padding(5)
            }
            .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always) , prompt: "Search Coin!")
            .onSubmit(of: .search) {
                coingeckoManager.callRequest(api: .search(search), decodingType: CoinForSearch.self) { result in
                    switch result {
                    case .success(let success):
                        coins = success.coins
                    case .failure(let failure):
                        print(failure)
                    }
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    CoinSearchView()
}
