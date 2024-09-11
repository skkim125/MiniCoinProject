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

struct Trending: Decodable, Hashable {
    let coins: [ResponseCoinForTrending]
    let nfts: [NFTForTrending]
}

struct ResponseCoinForTrending: Decodable, Hashable {
    let item: CoinForTrending
}

struct CoinForTrending: Decodable, Hashable {
    let id: String
    let name: String
    let symbol: String
    let small: String
    let data: CoinPrice
}

struct CoinPrice: Decodable, Hashable {
    let price: Double
    let price_change_percentage_24h: PricePer24HForTrending
}

struct PricePer24HForTrending: Decodable, Hashable {
    let krw: Double
}

struct NFTForTrending: Decodable, Hashable {
    let name: String
    let symbol: String
    let thumb: String
    let data: NFTPrice
}

struct NFTPrice: Decodable, Hashable {
    let floor_price: String
    let floor_price_in_usd_24h_percentage_change: String
}

struct CoinForMarket: Decodable, Hashable {
    let id: String
    let name: String
    let symbol: String
    let image: String
    let currentPrice: Double
    let priceChangeIn24h: Double
    let low24h: Double
    let high24h: Double
    let ath: Double
    let athDate: String
    let atl: Double
    let atlDate: String
    let lastUpdated: String
    let sparklineIn7d: PriceIn7d
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case image
        case currentPrice = "current_price"
        case priceChangeIn24h = "price_change_percentage_24h"
        case low24h = "low_24h"
        case high24h = "high_24h"
        case ath
        case athDate = "ath_date"
        case atl
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7d = "sparkline_in_7d"
    }
}

struct PriceIn7d: Decodable, Hashable {
    let price: [Double]
}
