//
//  CrashView.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 20.10.2023.
//

import SwiftUI

struct CrashView: View {
    var body: some View {
        ZStack {
            Color.gray.opacity(0.3).ignoresSafeArea()
            VStack {
                Button("Test Crash") {
                    fatalError("Crash was triggered")
                }
            }
        }
    }
}
    
struct CrashView_Previews: PreviewProvider {
    static var previews: some View {
        CrashView()
    }
}
