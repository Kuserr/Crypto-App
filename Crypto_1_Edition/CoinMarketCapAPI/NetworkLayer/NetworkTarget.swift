//
//  NetworkTarget.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 31.08.2023.
//

import Foundation
import Moya

enum NetworkTarget {
    case getCoinModels
}

extension NetworkTarget: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://pro-api.coinmarketcap.com/v1/") else {fatalError()}
            return url
        }
    
    var path: String {
        switch self {
        case .getCoinModels:
        return "cryptocurrency/listings/latest?start=1&limit=90&sort=market_cap&cryptocurrency_type=all&tag=all"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case .getCoinModels:
            return .requestPlain
        }
    }
    
    var sampleData: Data {
            return Data()
        }
    
    var validate: Bool { return true }
    
    var headers: [String : String]? {
        return ["Accept" : "application/json",
                "Accept-Encoding": "deflate, gzip",
                "X-CMC_PRO_API_KEY": token]
    }
}

let token = "c3cab33c-c6fa-4863-8f49-45091e5f5f5e"
let authPlugin = AccessTokenPlugin {_ in token }
let provider = MoyaProvider<NetworkTarget>(plugins: [authPlugin])

