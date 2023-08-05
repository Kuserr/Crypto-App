//
//  AlertsFor.swift
//  Crypto_1_Edition
//
//  Created by Сергей Курьян on 03.08.2023.
//

import SwiftUI

struct AlertsFor: View {
    @State private var presentAlert = false
    var body: some View {
        VStack {
            Button("Add to Portfolio") {
                presentAlert.toggle()
            }
            /*
            .alert("How much coins of \(viewModel.shortName) you want to add?", isPresented: $presentAlert) {
                TextField("Enter the quantity", text: $viewModel.quantity)
                    .keyboardType(.numberPad)
                Button("Save", action: submit)
                Button("Cancel", role: .cancel) {}
            }
            */
            
            .alert(isPresented: $presentAlert) {
                Alert(
                    title: Text("How much coins do you want to add?")
                    )}
            
            }
        }
   
    }


struct Alerts_Previews: PreviewProvider {
    static var previews: some View {
        AlertsFor()
    }
}


