//
//  VideoView.swift
//  KUTeach
//
//  Created by Sarp Vulaş on 13.01.2024.
//

import SwiftUI

struct VideoView: View {

    var video: Video

    var body: some View {
        VStack (spacing: 10){
            Image(video.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))

            Text(video.title)
                .font(.title2)
                .fontWeight(.semibold)
                .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)

            HStack {
                Label("\(video.viewCount)", systemImage: "eye.fill")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text(video.uploadDate)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Text(video.description)
                .font(.footnote)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)

            Spacer()

            Link(destination: video.url, label: {
                ButtonView(title: "Watch Now")
            })

            Spacer()

        }


    }
}

#Preview {
    VideoView(video: VideoList.topTen.first!)
}

struct ButtonView: View {

var title: String

var body: some View {
Text(title)
    .bold()
    .font(.custom("SFProText-Regular", size: 24))
    .frame(width:200, height: 50)
    .background(Color.red)
    .foregroundColor(.white)
    .clipShape(RoundedRectangle(cornerRadius: 10))
    .shadow(radius: 1, x:3, y:3)
}
}
