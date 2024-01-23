//
//  LecturerDashboardView.swift
//  KUTeach
//
//  Created by Zeynep Aydın on 1/23/24.
//

import Foundation
import SwiftUI

struct LecturerDashboardView: View {

    var videos: [Video] = VideoList.topTen

    @State private var searchTerm = ""

    var filteredSearchTerms: [Video] {
        guard !searchTerm.isEmpty else {return videos}
        return videos.filter {$0.title.localizedCaseInsensitiveContains(searchTerm)}
    }

    var body: some View {

        VStack {

            //panel()

            NavigationView {
                List(filteredSearchTerms, id: \.id) { video in
                    NavigationLink(destination: VideoView(video: video), label: {
                        VideoCellView(video: video)
                    })

                }.navigationTitle("Courses")
                    .navigationBarTitleDisplayMode(.inline)
                    .searchable(text: $searchTerm)
            }
        }


    }
}
