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
        persistentContainer = NSPersistentContainer(name: "HelloCoreData")
        
        persistentContainer.loadPersistentStores(completionHandler: { description, error in
            if let error = error {
                fatalError("Core Data store failed to load with error: \(error)")
            }
        })
    }
}

extension StorageProvider {
    func saveBook(_ bookToAdd: BookRes) {
        let book = Book(context: persistentContainer.viewContext)
        book.title = bookToAdd.title
        
        do {
            try persistentContainer.viewContext.save()
            print("Movie saved succesfully")
        } catch {
            print("Failed to save movie: \(error)")
        }
    }
}

extension StorageProvider {
    func getAllRecordsOf<T: NSManagedObject>(_ entity: T.Type) -> [T] {
        let fetchRequest = T.fetchRequest() as! NSFetchRequest<T>
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch movies: \(error)")
            return []
        }
    }
}

extension StorageProvider {
    func getAllBooks() -> [Book] {
        let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch movies: \(error)")
            return []
        }
    }
}

extension StorageProvider {
    func deleteRecordOf<T: NSManagedObject>(_ entity: T) {
        persistentContainer.viewContext.delete(entity)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context: \(error)")
        }
    }
}
