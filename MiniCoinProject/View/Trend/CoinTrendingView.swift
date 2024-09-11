//
//  CoinTrendingView.swift
//  MiniCoinProject
//
//  Created by 김상규 on 9/9/24.
//

import SwiftUI

struct CoinTrendingView: View {
    let rows = [ GridItem(.fixed(60)),
                 GridItem(.fixed(60)),
                 GridItem(.fixed(60))
    ]
    
    @State private var trending = Trending(coins: [], nfts: [])
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Top 15 Coin")
                        .font(.title2).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: rows)
                        {
                            ForEach(0..<trending.coins.count, id: \.self) { value in
                                TrendingRowView(type: .coin, index: value, object: trending)
                                    .frame(width: 330, height: 180)
                            }
                        }
                    }
                    .frame(height: 220)
                }
                .padding(.top)
                
                VStack {
                    Text("Top 7 NFTS")
                        .font(.title2).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: rows)
                        {
                            ForEach(0..<trending.nfts.count, id: \.self) { value in
                                TrendingRowView(type: .nft, index: value, object: trending)
                                    .frame(width: 330, height: 180)
                            }
                        }
                    }
                }
                .frame(height: 220)
                .padding(.top)
            }
            .scrollIndicators(.hidden)
            .onAppear { CoingeckoManager.shared.callRequest(api: .trending, decodingType: Trending.self, completionHandler: { result in
                switch result {
                case .success(let success):
                    DispatchQueue.main.async {
                        trending = success
                    }
                case .failure(let failure):
                    print(failure)
                }
            })
            }
            .navigationTitle("Trending")
        }
    }
}

#Preview {
    CoinTrendingView()
}

struct TrendingRowView: View {
    let type: TrendingType
    let index: Int
    let object: Trending
    @State var title: String = ""
    @State var symbol: String = ""
    @State var image: String = ""
    @State var price: String = ""
    @State var changePer: String = ""
    @State var isChanged: Bool = false
    
    var body: some View {
        HStack {
            Text("\(index+1)")
                .font(.title).bold().frame(height: 20)
            
            AsyncImage(url: URL(string: image)) { result in
                switch result {
                case .empty:
                    EmptyView()
                case .success(let image):
                    image
                        .resizable()
                        .frame(width: 40, height: 40)
                    
                case .failure(let error):
                    EmptyView()
                @unknown default:
                    fatalError()
                }
            }
            .padding(.leading, 15)
            
            VStack(alignment: .leading) {
                Text("\(title)")
                    .bold()
                    .lineLimit(1)
                
                Text("\(symbol)")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(price)
                Text(changePer)
                    .font(.caption)
                    .foregroundStyle(isChanged ? .red : .blue)
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            switch type {
            case .coin:
                let coin = object.coins[index]
                title = coin.item.name
                symbol = coin.item.symbol
                image = coin.item.small
                price = "\(Double(coin.item.data.price))"
                price = "\(String(format: "%.2f", Double(coin.item.data.price)))%"
                changePer = "\(String(format: "%.2f", Double(coin.item.data.price_change_percentage_24h.krw)))%"
                isChanged = Double(coin.item.data.price_change_percentage_24h.krw) > 0
                
            case .nft:
                let nft = object.nfts[index]
                title = nft.name
                symbol = nft.symbol
                image = nft.thumb
                price = nft.data.floor_price
                changePer = "\(String(format: "%.2f", Double(nft.data.floor_price_in_usd_24h_percentage_change)!))%"
                isChanged = Double(nft.data.floor_price_in_usd_24h_percentage_change) ?? 0 > 0
            }
        }
    }
}

enum TrendingType {
    case coin
    case nft
}
