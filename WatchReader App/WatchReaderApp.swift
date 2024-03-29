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
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            WatchReaderTabView()
                .environment(\.managedObjectContext, viewContext)
                .onChange(of: scenePhase) { _ in
                    StorageProvider.shared.save()
                }
        }
    }
}
