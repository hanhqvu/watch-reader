//
//  WatchReaderApp.swift
//  WatchReader WatchKit Extension
//
//  Created by Hanh Vu on 2022/08/18.
//

import SwiftUI

@main
struct WatchReaderApp: App {
    let viewContext = StorageProvider.shared.persistentContainer.viewContext
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                CurrentListView()
                    .environment(\.managedObjectContext, viewContext)
            }
        }
    }
}
