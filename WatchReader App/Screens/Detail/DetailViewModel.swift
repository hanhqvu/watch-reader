//
//  DetailViewModel.swift
//  WatchReader App
//
//  Created by Hanh Vu on 2023/08/06.
//

import Foundation
import CoreData

final class DetailViewModel: ObservableObject {
    var book: Book
    let storageProvider = StorageProvider.shared
    let viewContext: NSManagedObjectContext
    let detailContext: NSManagedObjectContext?
    
    init(sourceBook: Book) {
        guard let viewContext = sourceBook.managedObjectContext else {
            fatalError("Attempting to edit a managed object that's not associated with a context")
        }
        
        self.viewContext = viewContext
        let detailContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        detailContext.parent = viewContext
        
        guard let childBook = try? detailContext.existingObject(with: sourceBook.objectID) as? Book else {
            self.detailContext = nil
            self.book = sourceBook
            return
        }
        
        self.detailContext = detailContext
        self.book = childBook
    }
    
    func complete() {
        guard let detailContext = detailContext else { return }
        do {
            try detailContext.save()
        } catch {
        }
    }
}
