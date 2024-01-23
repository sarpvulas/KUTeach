//
//  StudentDashboardPanelView.swift
//  KUTeach
//
//  Created by Sarp Vulaş on 13.01.2024.
//

import SwiftUI

struct StudentPanelView: View {
    var user: User
    var body: some View {
        TabView{
            StudentProfilePageView(user: user)
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
            StudentDashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "list.dash.header.rectangle")
                }
            StudentSubscriptionView()
                .tabItem {
                    Label("Subscription", systemImage: "cart")
                }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    StudentPanelView(user: User(username:"test", email:"test", name: "test", isLecturer: false)).environmentObject(LoginViewModel())
}
