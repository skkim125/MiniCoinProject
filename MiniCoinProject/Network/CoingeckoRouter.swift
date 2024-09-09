//
//  CoingeckoRouter.swift
//  MiniCoinProject
//
//  Created by 김상규 on 9/9/24.
//

import Foundation
import Alamofire

enum CoingeckoRouter {
    case trending
    case search(String)
    case market(String)
    
    var baseURL: String {
        "https://api.coingecko.com/api/v3/"
    }
    
    var path: String {
        switch self {
        case .trending:
            "search/trending"
        case .search:
            "search"
        case .market:
            "coins/markets"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .trending:
            nil
        case .search(let query):
            [
                "query": "\(query)"
            ]
        case .market(let id):
            [
                "vs_currency": "krw",
                "ids": "\(id)"
            ]
        }
    }
}
