//
//  StudentDashboardPanelView.swift
//  KUTeach
//
//  Created by Sarp Vulaş on 13.01.2024.
//

import SwiftUI

struct StudentPanelView: View {
    var body: some View {
        TabView{
            StudentProfilePageView()
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

        }
    }
}

#Preview {
    StudentPanelView()
}
