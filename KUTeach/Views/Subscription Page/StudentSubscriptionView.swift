//
//  StudentSubscriptionView.swift
//  KUTeach
//
//  Created by Sarp Vulaş on 13.01.2024.
//

import SwiftUI

struct StudentSubscriptionView: View {

    var body: some View {

        ZStack(alignment: .center) {
            BackgroundDS(color1: .cyan, color2: .white)

            Heading1TextBlack(text: "Subscriptions")

        }
    }
}

#Preview {
    StudentSubscriptionView()
}
