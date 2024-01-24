//
//  VideoCellView.swift
//  KUTeach
//
//  Created by Sarp Vulaş on 13.01.2024.
//

import SwiftUI

struct VideoCellView: View {

    var video: Video
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Lecture: \(video.lectureName)") 
            Text(video.title)
                .fontWeight(.semibold)
            Text(video.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        HStack {
            Image(video.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 70)
                .clipShape(RoundedRectangle(cornerRadius: 6.0))
                .padding(.vertical, 4)

            VStack (alignment: .leading, spacing: 5){
                Text(video.title)
                    .fontWeight(.semibold)
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .minimumScaleFactor(0.5)

                Text(video.uploadDate)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

        }



    }
}

//#Preview {
//    let sampleVideo = Video(
//            userID: "someUserID", // Example userID
//            imageName: "exampleImage", // Example image name
//            title: "Example Video Title",
//            description: "This is a description for the example video.",
//            viewCount: 123,
//            uploadDate: "January 24, 2024",
//            url: URL(string: "https://example.com/video")! // Example URL
//        )
//        VideoCellView(video: sampleVideo)
//    }
