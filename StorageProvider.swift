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

extension BookEntity {
    var bookStatus: Status {
        get {
            return Status(rawValue: "\(String(describing: self.status))") ?? .reading
        }
        
        set {
            self.status = String(newValue.rawValue)
        }
    }
}

extension BookEntity {
    static var booksByRating: NSFetchRequest<BookEntity> = {
        let request: NSFetchRequest<BookEntity> = BookEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \BookEntity.rating, ascending: false)]
        
        return request
    }()
}
