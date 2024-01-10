//
//  TextDS.swift
//  KUTeach
//
//  Created by Sarp Vulaş on 10.01.2024.
//

import SwiftUI

// Button Text
struct ButtonTextDS: View {
    let text: String

    var body: some View {
        Text(text)
            .lineLimit(2)
            .font(.custom("SFProText-Regular", size: 17))
            .padding(.vertical, 8)
            .padding(.horizontal, 4)
    }
}

// Heading 1 Text
struct Heading1Text: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.custom("SFProDisplay-Bold", size: 24)) // Example size and weight
            .foregroundColor(.black)
            .lineLimit(nil)
    }
}

// Body Text
struct BodyText: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.custom("SFProText-Regular", size: 16)) // Example size
            .foregroundColor(.gray)
            .lineLimit(nil)
    }
}

// Caption Text
struct CaptionText: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.custom("SFProText-Regular", size: 12)) // Example size
            .foregroundColor(.secondary)
            .lineLimit(nil)
    }
}

