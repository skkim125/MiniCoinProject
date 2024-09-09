//
//  CoinSearchView.swift
//  MiniCoinProject
//
//  Created by 김상규 on 9/9/24.
//

import SwiftUI

struct CoinSearchView: View {
    @State private var search = ""
    
    var body: some View {
        NavigationView {
            CoinSearchRowView()
                .searchable(text: $search, prompt: "Search Coin!")
                .navigationTitle("Search")
        }
    }
}

#Preview {
    CoinSearchView()
}
