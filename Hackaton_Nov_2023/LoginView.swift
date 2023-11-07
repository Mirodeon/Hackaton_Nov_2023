//
//  Login.swift
//  Hackaton_Nov_2023
//
//  Created by Duc Luu on 07/11/2023.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email = "ludo@dolly.com"
    @State private var password = "dolly123"
    
    var body: some View {
        
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Button(action: {
                // Appel de la fonction de connexion en réponse à l'action de l'utilisateur
                self.login()
            }) {
                Text("Se connecter")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
    
    private func login() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error signing in: \(error.localizedDescription)")
            } else {
                print("Connecté avec succès")
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
