//
//  AuthDataModel.swift
//  Hackaton_Nov_2023
//
//  Created by Student07 on 07/11/2023.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class AuthDataModel: ObservableObject, Identifiable {
    
    static let instance = AuthDataModel()
    
    var user: User?
    
    func signin(email: String, password: String, action: @escaping (Bool) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            action(error == nil)
            if let user = authResult?.user {
                self.user = user
            }
        }
    }
    
    func signup(email: String, password: String, action: @escaping (Bool) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            action(error == nil)
            if let user = authResult?.user {
                self.user = user
            }
        }
    }
    
    func signout(email: String, password: String, action: @escaping (Bool) -> ()) {
        do {
            try Auth.auth().signOut()
            action(true)
            self.user = nil
        } catch {
            action(false)
        }
    }
}