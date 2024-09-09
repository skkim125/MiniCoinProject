//
//  Coin.swift
//  MiniCoinProject
//
//  Created by 김상규 on 9/9/24.
//

import Foundation

struct CoinForSearch: Decodable {
    let coins: [Coin]
}

struct Coin: Decodable, Hashable {
    let id: String
    let name: String
    let symbol: String
    let thumb: String
}
