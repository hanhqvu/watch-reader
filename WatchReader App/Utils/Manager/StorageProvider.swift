//
//  StorageProvider.swift
//  WatchReader App
//
//  Created by Hanh Vu on 2023/08/01.
//

import Foundation
import CoreData

class StorageProvider {
    static let shared = StorageProvider()
    
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

extension StorageProvider {
    func getBookByTitle(_ title: String, in context: NSManagedObjectContext) -> [BookEntity] {
        let fetchRequest: NSFetchRequest<BookEntity> = BookEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(BookEntity.title), title])
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch movies: \(error)")
            return []
        }
    }
}

extension StorageProvider {
    func save() {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                //Error persisting
                context.rollback()
            }
        }
    }
}

extension StorageProvider {
    func addBook(_ bookToAdd: BookRes, context: NSManagedObjectContext) -> BookEntity {
        let book = BookEntity(context: context)
        book.title = bookToAdd.title
        book.status = "Reading"
        book.imageKey = bookToAdd.imageKey
        book.summary = bookToAdd.title
        bookToAdd.author?.forEach { author in
            let authorToAdd = Author(context: context)
            authorToAdd.name = author
            book.addToAuthors(authorToAdd)
        }
        return book
    }
    
    func removeBook(_ addedBook: BookEntity, context: NSManagedObjectContext) {
        context.delete(addedBook)
    }
}
