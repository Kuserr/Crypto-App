//
//  ImageRetriver.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 29.09.2023.
//

import Foundation

struct ImageRetriver {
    func fetch(_ imgUrl: String) async throws -> Data {
        guard let url = URL(string: imgUrl) else {
            throw RetriverError.invalidUrl
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}

private extension ImageRetriver {
    enum RetriverError: Error {
        case invalidUrl
    }
}
