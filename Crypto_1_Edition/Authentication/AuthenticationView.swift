//
//  AuthenticationView.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 23.11.2023.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct AuthenticationView: View {
    
    @StateObject private var viewModel = AuthenticationViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        ZStack {
            Color.gray
            
            VStack(spacing: .leastNormalMagnitude) {
                Text("Welcome")
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .offset(x: -100, y: -100)
                
                Text("Please enter your login and password!")
                    .padding()
                    .foregroundColor(.white)
                    .font(.system(size: 15, weight: .light, design: .rounded))
              
                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 280, height: 15, alignment: .center)
                    .padding()
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 280, height: 15, alignment: .center)
                    .padding()
                
                HStack(alignment: .center) {
                    
                    Button("Sign In", action: {
                        Task {
                            do {
                                try await viewModel.signIn()
                                showSignInView = false
                                return
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }).frame(width: 70, height: 10)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.linearGradient(colors: [.pink, .red], startPoint: .top, endPoint: .bottomTrailing)))
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .padding()
                    
                    Button("Sign Up", action: {
                        Task {
                            do {
                                try await viewModel.signUp()
                                showSignInView = false
                                return
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                        
                    }).frame(width: 70, height: 10)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.linearGradient(colors: [.pink, .red], startPoint: .top, endPoint: .bottomTrailing)))
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .padding()
                }.padding(0)
                }
            .onAppear {
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                        viewModel.userIsLoggedIn.toggle()
                    }
                }
            }
            }
        .ignoresSafeArea()
    }
    }

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView(showSignInView: .constant(false))
    }
}
