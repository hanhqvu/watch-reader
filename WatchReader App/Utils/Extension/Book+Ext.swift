//
//  Book+Ext.swift
//  WatchReader App
//
//  Created by Hanh Vu on 2023/08/01.
//

import Foundation
import CoreData

extension Book {
    var bookStatus: Status {
        get {
            return Status(rawValue: "\(String(describing: self.status))") ?? .reading
        }
        
        set {
            self.status = String(newValue.rawValue)
        }
    }
}

extension Book {
    static var booksByRating: NSFetchRequest<Book> = {
        let request: NSFetchRequest<Book> = Book.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Book.rating, ascending: false)]
        
        return request
    }()
}

extension Book {
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
}

extension Book {
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
