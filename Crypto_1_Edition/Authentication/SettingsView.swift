//
//  SettingsView.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 23.11.2023.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
    func logOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}

struct SettingsView: View {
     
    @StateObject private var viewModel = SettingsViewModel()
    @State private var showSignInView: Bool = false
    
    var body: some View {
        ZStack {
            List {
                Button("Log out") {
                    Task {
                        do {
                            try viewModel.logOut()
                            showSignInView = true
                        } catch {
                            print(error)
                        }
                    }
                }
                .navigationBarTitle("Settings")
            }
        }
        .fullScreenCover(isPresented: $showSignInView) {
                AuthenticationView(showSignInView: $showSignInView)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView()
        }
    }
}
