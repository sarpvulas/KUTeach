//
//  StudentSubscriptionView.swift
//  KUTeach
//
//  Created by Sarp Vulaş on 13.01.2024.
//

import SwiftUI

struct StudentSubscriptionView: View {
    @ObservedObject var subscriptionVM: StudentSubscriptionViewModel
    
    var body: some View {
        ZStack(alignment: .center) {
            BackgroundDS(color1: .cyan, color2: .white)

            Heading1TextBlack(text: "Subscriptions")
            List {
                ForEach(subscriptionVM.subscribedVideos, id: \.id) { video in
                    HStack {
                        VideoCellView(video: video)
                        Spacer()
                        Button(action: {
                            subscriptionVM.unsubscribeVideo(videoID: video.id)
                        }) {
                            Image(systemName: "minus.circle")
                                .foregroundColor(.red)
                        }
                    }

                }
            }
            .onAppear {
                subscriptionVM.fetchSubscriptions()
            }
        }
    }
}


#Preview {
    StudentSubscriptionView(subscriptionVM: StudentSubscriptionViewModel(userID: "test"))
}
