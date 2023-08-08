//
//  RegistrationView.swift
//  KeyChain
//
//  Created by Davin Henrik on 8/3/23.
//

// RegistrationView.swift
import SwiftUI

struct RegistrationView: View {
    @Environment(\.dismiss) var dismiss
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var registrationError: Bool = false

    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: register) {
                Text("Register")
            }
            .padding()
            .alert(isPresented: $registrationError) {
                Alert(title: Text("Error"), message: Text("Registration failed"), dismissButton: .default(Text("OK")))
            }
        }
        .padding()
    }

    func register() {
        // Perform any necessary validation for the entered username and password here
        // For simplicity, let's assume the validation is successful.

        // Save the new user credentials to Keychain
        if KeychainHelper.savePassword(username: username, password: password) {
            print("Registration successful!")
            dismiss()
        } else {
            registrationError = true
        }
    }
}
