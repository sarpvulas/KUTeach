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
    var currentUserId: String? {
        return Auth.auth().currentUser?.uid
    }
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
            return AnyView(Text("Loading..."))
        }
        return AnyView(Text("Loading..."))
    }
    func login(withEmail email: String, password: String) {
        self.error = nil
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
        self.error = nil
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
    func changePassword(currentEmail: String, oldPassword: String, newPassword: String, completion: @escaping (Bool) -> Void) {
        self.error = nil
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
    func logout(completion: @escaping (Bool) -> Void) {
        self.error = nil
        do {
            self.loginSuccessful = false
            try Auth.auth().signOut()
            completion(true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            completion(false)
        }
    }
}
enum UserType {
    case student
    case lecturer
}
