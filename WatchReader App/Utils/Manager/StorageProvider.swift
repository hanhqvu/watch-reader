//
//  StorageProvider.swift
//  WatchReader App
//
//  Created by Hanh Vu on 2023/08/01.
//

import Foundation
import CoreData

class StorageProvider {
    
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "WatchReader")
        
        persistentContainer.loadPersistentStores(completionHandler: { description, error in
            if let error = error {
                fatalError("Core Data store failed to load with error: \(error)")
            }
        })
    }
}
