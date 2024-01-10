//
//  ContentView.swift
//  KUTeach
//
//  Created by Sarp Vulaş on 10.01.2024.
//

import SwiftUI

struct LoginView: View {

    @State private var loginText: String = ""
    @State private var passwordText: String = ""

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

                            Heading1Text(text: "Login Page")
                                .padding()

                            TextFieldDS(text: $loginText, placeholder: "Enter username")
                                           .padding()

                            TextFieldDS(text: $passwordText, placeholder: "Enter password")
                                           .padding()

                            ButtonDS(buttonTitle: "Login", action: viewModel.login)


                            Spacer()
                            Spacer()
                            Spacer()
                        }


            }
        }
    }
}

#Preview {
    LoginView()
}
