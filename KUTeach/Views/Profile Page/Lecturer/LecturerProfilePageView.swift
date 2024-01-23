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
    var body: some View {

        ZStack {
            BackgroundDS(color1: .cyan, color2: .white)

            VStack(spacing: 40) {

                HStack(spacing: 30) {
                    Image(systemName: "person.crop.square")
                        .resizable()
                        .frame(width: 75, height: 75)
                    
                    Heading1TextBlack(text: "Name Surname")
                        .frame(width:200, height: 50)
                        .background(Color.white)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 1, x:3, y:3)
                }

                HStack {
                    BodyText(text: "Teacher username: ")


                }
                .padding(.leading, -150)
                .frame(width:350, height: 50)
                    .background(Color.white)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 1, x:3, y:3)


                HStack {
                    BodyText(text: "email: ")


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
                    .frame(width:200, height: 50)
                    .background(Color.white)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 1, x:3, y:3)

                    TextFieldDSBlack(text: $oldPassword, placeholder: "Enter old password")
                    .frame(width: 300)

                    TextFieldDSBlack(text: $oldPassword, placeholder: "Enter new password")
                    .frame(width: 300)
            }
            .padding(.top, 300)

        }

    }
}

#Preview {
    LecturerProfilePageView(user: User(username:"test", email:"test", name: "test", isLecturer: true))
}
