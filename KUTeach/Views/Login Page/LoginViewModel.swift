//
//  LoginViewModel.swift
//  KUTeach
//
//  Created by Zeynep Aydın on 1/23/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class LoginViewModel: ObservableObject {
    @Published var loginSuccessful = false
    @Published var error: String?

    let auth = Auth.auth()
    let db = Firestore.firestore()

    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if let error = error {
                DispatchQueue.main.async {
                    strongSelf.error = error.localizedDescription
                    strongSelf.loginSuccessful = false
                }
                return
            }
            DispatchQueue.main.async {
                strongSelf.loginSuccessful = true
            }
        }
    }
}
