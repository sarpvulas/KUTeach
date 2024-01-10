import Foundation
import FirebaseAuth
import FirebaseFirestore

class LoginViewModel: ObservableObject {
    // Add an error property to display authentication errors
    @Published var error: String?
    let auth = Auth.auth()
    let db = Firestore.firestore()
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            // If there's an error, capture it and return
            guard let strongSelf = self else { return }
            if let error = error {
                strongSelf.error = error.localizedDescription
                return
            }

            // If authentication is successful, perform additional tasks like navigating to another view
            // ...
        }
    }

    func signUp(email: String, password: String, username: String) {
            auth.createUser(withEmail: email, password: password) { [weak self] authResult, error in
                if let error = error {
                    self?.error = error.localizedDescription
                } else {
                    // Assuming the sign-up was successful, save the user data to Firestore
                    if let userId = authResult?.user.uid {
                        self?.saveUserToDatabase(userId: userId, email: email, username: username)
                    }
                }
            }
        }

    private func saveUserToDatabase(userId: String, email: String, username: String) {
            db.collection("users").document(userId).setData([
                "username": username,
                "email": email
            ]) { [weak self] error in
                if let error = error {
                    self?.error = "Failed to save user: \(error.localizedDescription)"
                }
                // Handle successful save, such as updating the UI or transitioning views
            }
        }
}
