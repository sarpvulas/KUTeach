//
//  LecturerProfilePageView.swift
//  KUTeach
//
//  Created by Zeynep Aydın on 1/23/24.
//

import Foundation
import SwiftUI

struct LecturerProfilePageView: View {

    @State private var oldPassword: String = ""
    @State private var newPassword: String = ""
    var user: User
    @StateObject private var viewModel = LecturerProfilePageViewModel()
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
                    BodyText(text: "Teacher username: \(user.username)")


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
                    .frame(width:300, height: 50)
                    .background(Color.white)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 1, x:3, y:3)

                SecureFieldDSBlack(text: $oldPassword, placeholder: "Enter old password")
                    .frame(width: 300)

                SecureFieldDSBlack(text: $newPassword, placeholder: "Enter new password")
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
    LecturerProfilePageView(user: User(username:"test", email:"test", name: "test", isLecturer: true))
}
