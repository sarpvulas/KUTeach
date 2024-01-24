//
//  StudentSubscriptionViewModel.swift
//  KUTeach
//
//  Created by Zeynep Aydın on 1/24/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class StudentSubscriptionViewModel: ObservableObject {
    @Published var subscriptions: [Subscription] = []
    @Published var isLoading = false
    @Published var error: Error?
    @Published var userID: String
    @Published var subscribedVideos: [Video] = []

    private let db = Firestore.firestore()

    init(userID: String) {
        self.userID = userID
        print("Initialized ViewModel with userID: \(userID)")
    }

    func subscribeTo(video: Video) {
        isLoading = true
        error = nil

        let videoIDString = video.id.uuidString
        let newSubscription = Subscription(id: UUID().uuidString, userID: userID, videoID: videoIDString, videoName: video.videoName)

        let docRef = db.collection("subscriptions").document(newSubscription.id)

        docRef.setData([
            "id": newSubscription.id,
            "userID": newSubscription.userID,
            "videoID": newSubscription.videoID,
            "videoName": newSubscription.videoName
        ]) { [weak self] error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    self?.error = error
                    print("Error subscribing to video: \(error.localizedDescription)")
                } else {
                    self?.subscriptions.append(newSubscription)
                    self?.fetchVideoDetails()
                }
            }
        }
    }


    func fetchSubscriptions() {
        isLoading = true
        error = nil

        print("Starting to fetch subscriptions for userID: \(userID)")

        db.collection("subscriptions").whereField("userID", isEqualTo: userID).getDocuments { [weak self] snapshot, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    self?.error = error
                    print("Error fetching subscriptions: \(error.localizedDescription)")
                } else if let documents = snapshot?.documents, !documents.isEmpty {
                    print("Successfully fetched \(documents.count) subscriptions for userID: \(self?.userID ?? "unknown")")

                    let fetchedSubscriptions = documents.compactMap { doc -> Subscription? in
                        let data = doc.data()
                        let videoID = data["videoID"] as? String
                        guard let videoName = data["videoName"] as? String else {
                            print("Document \(doc.documentID) does not contain a videoName")
                            return nil
                        }
                        return Subscription(id: doc.documentID, userID: self?.userID ?? "", videoID: videoID ?? "not indicated", videoName: videoName)
                    }

                    self?.subscriptions = fetchedSubscriptions
                    print("Subscriptions are now set with \(fetchedSubscriptions.count) items.")
                    self?.fetchVideoDetails()
                } else {
                    print("No subscriptions found for userID: \(self?.userID ?? "unknown")")
                    self?.subscriptions = []
                }
            }
        }
    }


    func fetchVideoDetails() {
        isLoading = true
        error = nil

        let videoNames = subscriptions.map { $0.videoName }
        guard !videoNames.isEmpty else {
            self.subscribedVideos = []
            print("No video names to fetch.")
            isLoading = false
            return
        }

        print("Fetching video details for video names: \(videoNames)")

        db.collection("videos").whereField("videoName", in: videoNames).getDocuments { [weak self] (querySnapshot, err) in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let err = err {
                    self?.error = err
                    print("Error getting videos: \(err.localizedDescription)")
                } else if let documents = querySnapshot?.documents, !documents.isEmpty {
                    print("Successfully fetched \(documents.count) video details.")

                    let fetchedVideos = documents.compactMap { document -> Video? in
                        let data = document.data()
                        guard
                            let userID = data["userID"] as? String,
                            let videoURLString = data["videoURL"] as? String,
                            let url = URL(string: videoURLString),
                            let uploadDateTimestamp = data["uploadDate"] as? Double
                        else {
                            print("Error parsing video data for document \(document.documentID). Data: \(data)")
                            return nil
                        }

                        let date = Date(timeIntervalSince1970: uploadDateTimestamp)
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        let uploadDate = dateFormatter.string(from: date)

                        return Video(
                            userID: userID,
                            imageName: data["imageName"] as? String,
                            title: data["title"] as? String,
                            description: data["description"] as? String,
                            viewCount: data["viewCount"] as? Int,
                            uploadDate: uploadDate,
                            url: url,
                            lectureName: data["lectureName"] as? String ?? "Unknown",
                            videoName: data["videoName"] as? String ?? "Unknown",
                            videoDescription: data["videoDescription"] as? String ?? "No Description"
                        )
                    }

                    self?.subscribedVideos = fetchedVideos
                    print("Video details are now set with \(fetchedVideos.count) items.")
                } else {
                    print("No video details found for video names: \(videoNames)")
                    self?.subscribedVideos = []
                }
            }
        }
    }



    func unsubscribeVideo(videoID: String) {
        isLoading = true
        error = nil

        if let index = subscriptions.firstIndex(where: { $0.videoID == videoID }) {
            let subscriptionToDelete = subscriptions[index]
            let docRef = db.collection("subscriptions").document(subscriptionToDelete.id)
            docRef.delete { [weak self] error in
                DispatchQueue.main.async {
                    self?.isLoading = false
                    if let error = error {
                        self?.error = error
                        print("Error deleting subscription: \(error)")
                    } else {
                        self?.subscriptions.remove(at: index)
                        self?.fetchVideoDetails()
                    }
                }
            }
        } else {
            isLoading = false
        }
    }
}
