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
    private let db = Firestore.firestore()
    @Published var userID: String 
    @Published var subscribedVideos: [Video] = []

    init(userID: String) {
        self.userID = userID
    }

    func subscribeTo(video: Video) {
        let newSubscription = Subscription(id: UUID().uuidString, userID: userID, videoID: video.id.uuidString)
        let docRef = db.collection("subscriptions").document(newSubscription.id)

        docRef.setData([
            "id": newSubscription.id,
            "userID": newSubscription.userID,
            "videoID": newSubscription.videoID
        ]) { [weak self] error in
            if let error = error {
                print("Error subscribing to video: \(error)")
            } else {
                DispatchQueue.main.async {
                    self?.subscriptions.append(newSubscription)
                    self?.fetchVideoDetails()
                }
            }
        }
    }


    func fetchSubscriptions() {
            db.collection("subscriptions").whereField("userID", isEqualTo: userID).getDocuments { [weak self] snapshot, error in
                if let error = error {
                    print("Error fetching subscriptions: \(error)")
                    return
                }

                if let documents = snapshot?.documents {
                    let fetchedSubscriptions = documents.compactMap { doc -> Subscription? in
                        let data = doc.data()
                        guard let videoID = data["videoID"] as? String else { return nil }
                        return Subscription(id: doc.documentID, userID: self?.userID ?? "", videoID: videoID)
                    }

                    DispatchQueue.main.async {
                        self?.subscriptions = fetchedSubscriptions
                        self?.fetchVideoDetails()
                    }
                }
            }
        }

    func fetchVideoDetails() {
            let videoIDs = subscriptions.map { $0.videoID }
            guard !videoIDs.isEmpty else {
                self.subscribedVideos = []
                return
            }

            db.collection("videos").whereField(FieldPath.documentID(), in: videoIDs).getDocuments { [weak self] (querySnapshot, err) in
                if let err = err {
                    print("Error getting videos: \(err)")
                    return
                }

                if let documents = querySnapshot?.documents {
                    let fetchedVideos = documents.compactMap { document -> Video? in
                        let data = document.data()
                        return Video(
                            userID: data["userID"] as? String ?? "",
                            imageName: data["imageName"] as? String ?? "defaultImage",
                            title: data["title"] as? String ?? "",
                            description: data["description"] as? String ?? "",
                            viewCount: data["viewCount"] as? Int ?? 0,
                            uploadDate: data["uploadDate"] as? String ?? "",
                            url: URL(string: data["videoURL"] as? String ?? "") ?? URL(fileURLWithPath: ""),
                            lectureName: data["lectureName"] as? String ?? "",
                            videoName: data["videoName"] as? String ?? "",
                            videoDescription: data["videoDescription"] as? String ?? ""
                        )
                    }

                    DispatchQueue.main.async {
                        self?.subscribedVideos = fetchedVideos
                    }
                }
            }
        }
}
