//
//  DetailViewModel.swift
//  WatchReader App
//
//  Created by Hanh Vu on 2023/08/06.
//

import Foundation
import CoreData

final class DetailViewModel: ObservableObject {
    let storageProvider = StorageProvider.shared
    let viewContext: NSManagedObjectContext
    let detailContext: NSManagedObjectContext
    
    init() {
        viewContext = storageProvider.persistentContainer.viewContext
        detailContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        detailContext.parent = viewContext
    }
}
