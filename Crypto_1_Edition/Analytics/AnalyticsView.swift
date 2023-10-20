//
//  AnalyticsView.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 20.10.2023.
//

import SwiftUI
import FirebaseAnalytics
import FirebaseAnalyticsSwift
import Firebase

final class AnalyticsManager {
    
    static let shared = AnalyticsManager()
    private init() {}
    
    func logEvent(name: String, params: [String:Any]? = nil) {
        Analytics.logEvent(name, parameters: params)
    }
    
    func setUserId(userId: String) {
        Analytics.setUserID(userId)
    }
    
    func setUserProperty(value: String?, property: String) {
        Analytics.setUserProperty(value, forName: property)
    }
}

struct AnalyticsView: View {
    var body: some View {
        VStack {
            Button("Click me!") {
                AnalyticsManager.shared.logEvent(name: "AnalyticsView_ButtonClick")
            }
            Button("Click me too!") {
                AnalyticsManager.shared.logEvent(name: "AnalyticsView_SecondaryButtonClick", params: [
                    "screen_title" : "Hello, world!"
                ])
            }
        }
        .analyticsScreen(name: "AnalyticsView")
        .onAppear {
            AnalyticsManager.shared.logEvent(name: "AnalyticsView_Appear")
        }
        .onAppear {
            AnalyticsManager.shared.logEvent(name: "AnalyticsView_Disappear")
            AnalyticsManager.shared.setUserId(userId: "ABC123")
            AnalyticsManager.shared.setUserProperty(value: true.description, property: "user_is_premium")
        }
    }
}

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView()
    }
}
