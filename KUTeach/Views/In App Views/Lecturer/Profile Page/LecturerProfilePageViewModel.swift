//
//  LecturerProfilePageViewModel.swift
//  KUTeach
//
//  Created by Zeynep Aydın on 1/23/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
class LecturerProfilePageViewModel: ObservableObject {
    @Published var error: String?

    func changePassword(currentEmail: String, oldPassword: String, newPassword: String, completion: @escaping (Bool) -> Void) {
        guard !oldPassword.isEmpty, !newPassword.isEmpty else {
            self.error = "Password fields cannot be empty"
            completion(false)
            return
        }

        if let currentUser = Auth.auth().currentUser {
            currentUser.reauthenticate(with: EmailAuthProvider.credential(withEmail: currentEmail, password: oldPassword)) { result, error in
                if let error = error {
                    self.error = "Re-authentication error: \(error.localizedDescription)"
                    completion(false)
                    return
                }

                currentUser.updatePassword(to: newPassword) { error in
                    if let error = error {
                        self.error = "Password update error: \(error.localizedDescription)"
                        completion(false)
                    } else {
                        completion(true)
                    }
                }
            }
        } else {
            self.error = "User not found"
            completion(false)
        }
    }


}
