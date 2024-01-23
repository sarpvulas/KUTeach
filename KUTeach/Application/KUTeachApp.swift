//
//  KUTeachApp.swift
//  KUTeach
//
//  Created by Sarp Vulaş on 10.01.2024.
//

import SwiftUI


@main
struct KUTeachApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            SignUpView()
        }
    }
}
