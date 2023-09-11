//
//  NetworkTarget.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 31.08.2023.
//

import Foundation
import SwiftUI
import Moya


enum NetworkTarget {
    case getCoinModels
    case getCoinImages(coinsIds: String)
}

extension NetworkTarget: TargetType {
    
    private var token: String {
        let apiToken = "c3cab33c-c6fa-4863-8f49-45091e5f5f5e"
        return apiToken
    }
    
    var baseURL: URL {
        guard let url = URL(string: "https://pro-api.coinmarketcap.com") else {fatalError()}
            return url
        }
    
    var path: String {
        switch self {
        case .getCoinModels:
            return "/v1/cryptocurrency/listings/latest"
        case .getCoinImages:
            return "/v2/cryptocurrency/info"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Moya.Task {
        switch self {
        case .getCoinModels:
            return .requestPlain
        case .getCoinImages(let coinsIds):
            return .requestParameters(parameters: [
                "id" : "\(coinsIds)",
                "aux" : "urls,logo,description"],
                                      encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Accept" : "application/json",
                "Accept-Encoding": "deflate, gzip", "X-CMC_PRO_API_KEY": token]
    }
}
