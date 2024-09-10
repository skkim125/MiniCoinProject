//
//  CoinDetailView.swift
//  MiniCoinProject
//
//  Created by 김상규 on 9/10/24.
//

import SwiftUI

struct CoinDetailView: View {
    @Binding var coin: Coin
    @State private var coinData: CoinForMarket?
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    AsyncImage(url: URL(string: coinData?.image ?? "")) { result in
                        switch result {
                        case .empty:
                            EmptyView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                            
                        case .failure(let error):
                            EmptyView()
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                    Text("\(coinData?.name ?? "")")
                        .font(.largeTitle).bold()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            }
        }
        .onAppear {
            CoingeckoManager.shared.callRequest(api: .market(coin.id), decodingType: [CoinForMarket].self) { result in
                switch result {
                case .success(let success):
                    guard let coin = success.first else { return }
                    coinData = coin
                    print(coinData)
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
}

#Preview {
    CoinDetailView(coin: .constant(Coin(id: "bitcoin", name: "Bitcoin", symbol: "btc", thumb: "")))
}
