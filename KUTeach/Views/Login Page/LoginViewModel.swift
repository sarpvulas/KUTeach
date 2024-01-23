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
    @Published var currentUser: User?

    let auth = Auth.auth()
    let db = Firestore.firestore()

    var destinationView: AnyView {
        switch userType {
        case .student:
            if let user = currentUser {
                return AnyView(StudentPanelView(user: user))
            }
        case .lecturer:
            if let user = currentUser {
                return AnyView(LecturerPanelView(user: user))
            }
        default:
            return AnyView(Text("Unknown user type"))
        }
        return AnyView(Text("Loading..."))
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
                if let userData = document.data() {
                    let isLecturer = userData["isLecturer"] as? Bool ?? false
                    let username = userData["username"] as? String ?? ""
                    let email = userData["email"] as? String ?? ""
                    let name = userData["name"] as? String ?? ""
                    self?.userType = isLecturer ? .lecturer : .student
                    DispatchQueue.main.async {
                        self?.currentUser = User(username: username, email: email, name: name, isLecturer: isLecturer)
                    }
                }
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

