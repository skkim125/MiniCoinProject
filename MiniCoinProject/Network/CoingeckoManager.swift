//
//  CoingeckoManager.swift
//  MiniCoinProject
//
//  Created by 김상규 on 9/9/24.
//

import Foundation
import Alamofire

final class CoingeckoManager {
    static let shared = CoingeckoManager()
    private init() { }
    
    func callRequest<T: Decodable>(api: CoingeckoRouter, decodingType: T.Type, completionHandler: @escaping ((Result<T, Error>) -> Void)) {
        let urlString = api.baseURL + api.path
        
        guard let url = URL(string: urlString) else { return }
        
        AF.request(url, method: .get, parameters: api.parameters).responseDecodable(of: decodingType) { response in
            switch response.result {
            case .success(let success):
                completionHandler(.success(success))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
