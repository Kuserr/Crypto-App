//
//  ActivityIndicatorView.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 30.09.2023.
//

import Foundation
import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    typealias UIViewType = UIActivityIndicatorView
    let style : UIActivityIndicatorView.Style
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> ActivityIndicator.UIViewType {
        return UIActivityIndicatorView(style: style)
    }
    func updateUIView(_ uiView: ActivityIndicator.UIViewType, context: UIViewRepresentableContext<ActivityIndicator>) {
        uiView.startAnimating()
    }
}
