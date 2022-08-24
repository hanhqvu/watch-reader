//
//  WatchReaderApp.swift
//  WatchReader WatchKit Extension
//
//  Created by Hanh Vu on 2022/08/18.
//

import SwiftUI

@main
struct WatchReaderApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
