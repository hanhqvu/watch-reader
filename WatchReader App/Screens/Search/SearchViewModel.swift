//
//  SearchViewModel.swift
//  WatchReader App
//
//  Created by Hanh Vu on 2023/08/02.
//

import Foundation
import CoreData

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var keyword: String = ""
    @Published var searchResult: [BookRes] = []
    @Published var isLoading: Bool = false
    var newBooks: [BookEntity] = []
    let storageProvider = StorageProvider.shared
    let viewContext: NSManagedObjectContext
    let searchContext: NSManagedObjectContext
    
    init() {
        viewContext = storageProvider.persistentContainer.viewContext
        searchContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        searchContext.parent = viewContext
    }
    
    func addBook(_ bookToAdd: BookRes) -> BookEntity {
        let book = BookEntity(context: searchContext)
        book.title = bookToAdd.title
        book.status = "Reading"
        book.imageKey = bookToAdd.imageKey
        book.summary = bookToAdd.title
        bookToAdd.author?.forEach { author in
            let authorToAdd = Author(context: searchContext)
            authorToAdd.name = author
            book.addToAuthors(authorToAdd)
        }
        return book
    }
    
    func removeBook(_ addedBook: BookEntity) {
        addedBook.authorArray.forEach { author in
            author.removeFromBooks(addedBook)
        }
        searchContext.delete(addedBook)
        print("removed")
    }
    
    func complete() {
        print(searchContext.insertedObjects)
        do {
            try searchContext.save()
            print("Books saved succesfully")
        } catch {
            print("Failed to save books")
        }
    }
    
    func getSearchResults() async {
        isLoading.toggle()
        searchResult = await NetworkManager.shared.searchData(with: keyword)
        isLoading.toggle()
    }
}
