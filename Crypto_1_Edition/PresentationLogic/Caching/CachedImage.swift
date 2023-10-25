//
//  CachedImage.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 29.09.2023.
//

import SwiftUI

struct CachedImage: View {
    
    @StateObject private var manager = CachedImageManager()
    let url: String
    
    var body: some View {
        ZStack {
            if let data = manager.data,
               let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height:32)
            }
        }
        .task {
            await manager.load(url)
        }
    }
}

struct CachedImage_Previews: PreviewProvider {
    static var previews: some View {
        CachedImage(url: "https://s2.coinmarketcap.com/static/img/coins/64x64/1.png")
    }
}
