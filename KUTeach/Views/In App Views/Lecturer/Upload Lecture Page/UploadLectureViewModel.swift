//
//  UploadLectureViewModel.swift
//  KUTeach
//
//  Created by Sarp Vulaş on 21.01.2024.
//

import Foundation
import SwiftUI
import PhotosUI
import Firebase

class UploadLectureViewModel: ObservableObject {

    @Published var lectureName: String = ""
    @Published var videoName: String = ""
    @Published var videoDescription: String = ""

    @Published var selectedItem: PhotosPickerItem? {
        didSet {
            Task {
                try await uploadVideo()
            }
        }
    }

    init() {
        Task {try await fetchVideos() }
    }



    func uploadVideo() async throws -> Bool {
        guard let item = selectedItem else { return false }
        guard let videoData = try await item.loadTransferable(type: Data.self) else { return false}

        guard let videoURL = try await VideoUploader.uploadVideo(withData: videoData) else { return false }

        try await Firestore.firestore().collection("videos").document().setData(["videoURL": videoURL])

        return true

    }

    func fetchVideos() async throws {
        let snapshot = try await Firestore.firestore().collection("videos").getDocuments()

        for doc in snapshot.documents {
            print(doc.data())
        }
    }



}