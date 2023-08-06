//
//  DetailViewModel.swift
//  WatchReader App
//
//  Created by Hanh Vu on 2023/08/06.
//

import Foundation
import CoreData

final class DetailViewModel: ObservableObject {
    @Published var book: Book
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

        if let childBook = try? detailContext.existingObject(with: sourceBook.objectID) as? Book {
            self.detailContext = detailContext
            self.book = childBook
        } else if let childBook = detailContext.insertedObjects.first(where: { $0 == sourceBook }) as? Book {
            self.detailContext = detailContext
            self.book = childBook
        } else {
            self.detailContext = nil
            self.book = sourceBook
        }
    }

    func complete() {
        guard let detailContext = detailContext else { return }
        do {
            try detailContext.save()
        } catch {
        }
    }
}
