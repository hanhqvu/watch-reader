//
//  Book+Ext.swift
//  WatchReader App
//
//  Created by Hanh Vu on 2023/08/01.
//

import Foundation
import CoreData

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
