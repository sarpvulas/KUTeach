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

#Preview {
    VideoCellView(video: VideoList.topTen.first!)
}
