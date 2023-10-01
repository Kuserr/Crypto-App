//
//  ImageCache.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 29.09.2023.
//

import Foundation

class ImageCache {
    typealias CacheType = NSCache<NSString, NSData>
    static let shared = ImageCache()
    private init() {}
    private lazy var cache: CacheType = {
        let cache = CacheType()
        cache.countLimit = 100
        cache.totalCostLimit = 80 * 1024 * 1024 // 80 MB
        return cache
    }()
    func object(forkey key: NSString) -> Data? {
        cache.object(forKey: key) as? Data
    }
    func set(object: NSData, forKey key: NSString) {
        cache.setObject(object, forKey: key)
    }
}
