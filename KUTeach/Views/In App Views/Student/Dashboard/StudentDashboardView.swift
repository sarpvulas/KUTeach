//
//  StudentDashboardView.swift
//  KUTeach
//
//  Created by Sarp Vulaş on 13.01.2024.
//

import SwiftUI

struct StudentDashboardView: View {

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


#Preview {
    StudentDashboardView()
}
