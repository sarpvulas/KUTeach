//
//  StudentProfilePageView.swift
//  KUTeach
//
//  Created by Sarp Vulaş on 13.01.2024.
//

import SwiftUI

struct StudentProfilePageView: View {

    @State private var oldPassword: String = ""
    @State private var newPassword: String = ""
    @StateObject private var viewModel = StudentProfilePageViewModel()
    var user: User

    var body: some View {

        ZStack {
            BackgroundDS(color1: .cyan, color2: .white)

            VStack(spacing: 40) {

                HStack(spacing: 30) {
                    Image(systemName: "person.crop.square")
                        .resizable()
                        .frame(width: 75, height: 75)

                    Heading1TextBlack(text: user.name)
                        .frame(width:200, height: 50)
                        .background(Color.white)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 1, x:3, y:3)
                }

                HStack {
                    BodyText(text: "Student username: \(user.username)")
                }
                .padding(.leading, -150)
                .frame(width:350, height: 50)
                .background(Color.white)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 1, x:3, y:3)


                HStack {
                    BodyText(text: "Email: \(user.email)")
                }.padding(.leading, -150)
                    .frame(width:350, height: 50)
                    .background(Color.white)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 1, x:3, y:3)

                HStack {
                    BodyText(text: "Subscribed lectures: ")

                }
                .padding(.leading, -150)
                .frame(width:350, height: 50)
                .background(Color.white)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 1, x:3, y:3)

            }
            .padding(.top, -325)
            .padding(.horizontal, -175)

            VStack (spacing: 30){
                Heading1TextBlack(text: "Change Password")
                    .frame(width:250, height: 50)
                    .background(Color.white)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 1, x:3, y:3)

                TextFieldDSBlack(text: $oldPassword, placeholder: "Enter old password")
                    .frame(width: 300)

                TextFieldDSBlack(text: $oldPassword, placeholder: "Enter new password")
                    .frame(width: 300)

                ButtonDS(buttonTitle: "Change now!") {
                    viewModel.changePassword(currentEmail: user.email, oldPassword: oldPassword, newPassword: newPassword) { success in
                        if success {
                            print("Password successfully updated")
                        } else {
                            print("Failed to update password: \(viewModel.error ?? "Unknown error")")
                        }
                    }
                }
            }
            .padding(.top, 400)

        }

    }
}

#Preview {
    StudentProfilePageView(user: User(username:"test", email:"test", name: "test", isLecturer: false))
}
