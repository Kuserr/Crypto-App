//
//  CachedImageManager.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 29.09.2023.
//

import Foundation

final class CachedImageManager: ObservableObject {
    @Published private(set) var data: Data?
    private let imageRetriver = ImageRetriver()
    @MainActor
    func load(_ imgUrl: String,
              cache: ImageCache = .shared) async {
        if let imageData = cache.object(forkey: imgUrl as NSString) {
            self.data = imageData
            print("Fetching image from the cache: \(imgUrl)")
            return
        }
        do {
            self.data = try await imageRetriver.fetch(imgUrl)
            if let dataToCache = data as? NSData {
                cache.set(object: dataToCache, forKey: imgUrl as NSString)
                print("Caching image: \(imgUrl)")
            }
            self.data = try await imageRetriver.fetch(imgUrl)
        } catch {
            print(error)
        }
    }
}
