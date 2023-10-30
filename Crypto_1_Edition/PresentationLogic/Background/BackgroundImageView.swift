//
//  BackgroundImageView.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 25.10.2023.
//

import SwiftUI

struct BackgroundImageView: View {
    var body: some View {
        GeometryReader { geo in
                Image("backgroundImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
        }
        }
}

struct BackgroundImageView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundImageView()
    }
}
