//
//  CoinSearchRowView.swift
//  MiniCoinProject
//
//  Created by 김상규 on 9/9/24.
//

import SwiftUI

struct CoinSearchRowView: View {
    @Binding var coin: Coin
    @Binding var myCoins: [Coin]
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: coin.thumb)) { result in
                switch result {
                case .empty:
                    EmptyView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    
                case .failure(let error):
                    EmptyView()
                    
                @unknown default:
                    EmptyView()
                }
            }
            .scaledToFit()
            .frame(width: 40, height: 40)
            
            VStack(alignment: .leading) {
                Text("\(coin.name)")
                    .font(.title3).bold()
                    .lineLimit(1)
                
                Text("\(coin.symbol)")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .padding(.leading, 10)
            
            Spacer()
            
            Button {
                if myCoins.contains(where: { $0.id == coin.id }) {
                    guard let index = myCoins.firstIndex(where: { $0.id == coin.id }) else { return }
                    
                    myCoins.remove(at: index)
                    
                } else {
                    myCoins.append(coin)
                }
                
            } label: {
                let isLike = myCoins.contains(where: { $0.id == coin.id })
                Image(systemName: isLike ? "star.fill" : "star")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

#Preview {
    CoinSearchRowView(coin: .constant(Coin(id: "", name: "비트코인", symbol: "BTC", thumb: "star.fill")), myCoins: .constant([]))
}
