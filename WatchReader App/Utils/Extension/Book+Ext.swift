//
//  Book+Ext.swift
//  WatchReader App
//
//  Created by Hanh Vu on 2023/08/01.
//

import Foundation
import CoreData

extension Book {
    // computed properties for convinence usage
    var bookStatus: Status {
        get {
            return Status(rawValue: "\(String(describing: self.status))") ?? .reading
        }
        
        set {
            self.status = String(newValue.rawValue)
        }
    }
    
    var authorArray: [Author] {
        get {
            let set = self.authors as? Set<Author> ?? []
            return set.sorted {
                $0.name! < $1.name!
            }
        }
        
        set {
            self.authors = NSSet(array: newValue)
        }
    }
    
    var ratingInt: Int? {
        get {
            return Int(self.rating)
        }
        
        set {
            guard let newValue = newValue else { return }
            self.rating = Int16(newValue)
        }
    }
}

extension Book {
    // fetch request with different sort
    static var readingByProgress: NSFetchRequest<Book> = {
        let request: NSFetchRequest<Book> = Book.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Book.progress, ascending: false)]
        request.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(Book.status), "Reading"])
        
        return request
    }()
    
    static var readByProgress: NSFetchRequest<Book> = {
        let request: NSFetchRequest<Book> = Book.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Book.progress, ascending: false)]
        let finishedPredicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(Book.status), "Finished"])
        let abandonedPredicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(Book.status), "Abandoned"])
        let finishedOrAbandoned = NSCompoundPredicate(orPredicateWithSubpredicates: [finishedPredicate, abandonedPredicate])
        request.predicate = finishedOrAbandoned
        
        return request
    }()
}
