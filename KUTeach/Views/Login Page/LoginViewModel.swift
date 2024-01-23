//
//  LoginViewModel.swift
//  KUTeach
//
//  Created by Zeynep Aydın on 1/23/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var loginSuccessful = false
    @Published var error: String?
    @Published var userType: UserType?

    let auth = Auth.auth()
    let db = Firestore.firestore()

    var destinationView: AnyView {
        switch userType {
        case .student:
            return AnyView(StudentProfilePageView())
        case .lecturer:
            return AnyView(LecturerProfilePageView())
        default:
            return AnyView(Text("Unknown user type"))
        }
    }

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
            if let userId = authResult?.user.uid {
                self?.fetchUserType(userId: userId)
            }
        }
    }

    private func fetchUserType(userId: String) {
        let ref = db.collection("users").document(userId)
        ref.getDocument { [weak self] (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                let isLecturer = data?["isLecturer"] as? Bool ?? false
                self?.userType = isLecturer ? .lecturer : .student
            } else {
                self?.error = "User data not found."
            }
        }
    }
}

enum UserType {
    case student
    case lecturer
}

