//
//  LoginView.swift
//  KeyChain
//
//  Created by Davin Henrik on 8/3/23.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var loginError: Bool = false

    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: login) {
                Text("Login")
            }
            .padding()
            
            NavigationLink(destination: RegistrationView()) {
                           Text("New User?")
                       }
        }
        .padding()
        .alert(isPresented: $loginError) {
            Alert(title: Text("Error"), message: Text("Invalid username or password"), dismissButton: .default(Text("OK")))
        }
    }

    func login() {
        // First, try to validate the user using the Keychain
        if let savedPassword = KeychainHelper.getPassword(username: username), savedPassword == password {
            // Successfully logged in using Keychain, you can navigate to the main app here
            // For simplicity, let's just print a success message.
            print("Login successful!")
        } else if username == "User123" && password == "Password123" {
            // Default sign-in mechanism, replace with your own custom logic as needed
            // For simplicity, let's just print a success message.
            print("Login successful!")
        } else {
            loginError = true
        }
    }
}
