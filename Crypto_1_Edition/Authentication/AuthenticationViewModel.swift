//
//  AuthenticationViewModel.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 23.11.2023.
//

import Foundation
import Firebase
import SwiftUI

@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var userIsLoggedIn: Bool = false
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        let returnedUserData = try await AuthenticationManager.shared.register(email: email, password: password)
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
}
