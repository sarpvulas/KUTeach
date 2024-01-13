//
//  ContentView.swift
//  KUTeach
//
//  Created by Sarp Vulaş on 10.01.2024.
//

import SwiftUI

struct LoginView: View {

    @State private var usernameText: String = ""
    @State private var passwordText: String = ""
    @State private var emailText: String = ""

    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        NavigationView {

                    ZStack(alignment: .center) {
                        BackgroundDS(color1: .cyan, color2: .white)
                                    Circle()
                                        .scale(1.5)
                                        .foregroundColor(.blue)

                                    Circle()
                                        .scale(2)
                                        .foregroundColor(.blue.opacity(0.15))


                        VStack {
                            Spacer()
                            Image(systemName: "person.crop.square")
                                .font(.system(size: 100))
                                .foregroundStyle(.purple)

                            Heading1TextWhite(text: "Login Page")
                                .padding()

                            TextFieldDSWhite(text: $emailText, placeholder: "Enter email")
                                           .padding()
                            
                            TextFieldDSWhite(text: $usernameText, placeholder: "Enter username").padding()

                            TextFieldDSWhite(text: $passwordText, placeholder: "Enter password")
                                           .padding()

                            //SecureField("Enter password", text: $passwordText).padding()

                            ButtonDS(buttonTitle: "Login", action: {
                                viewModel.login(withEmail: emailText, password: passwordText)
                            })

                            ButtonDS(buttonTitle: "Sign Up", action: {
                                            viewModel.signUp(email: emailText, password: passwordText, username: usernameText)
                                        }).padding()


                            Spacer()
                            Spacer()
                            Spacer()

                            if let error = viewModel.error {
                                            Text(error)
                                                .foregroundColor(.red)
                                        }
                        }
            }
        }
    }
}

#Preview {
    LoginView()
}
