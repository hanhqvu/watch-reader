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
    var newBooks: [Book] = []
    let storageProvider = StorageProvider.shared
    let viewContext: NSManagedObjectContext
    let searchContext: NSManagedObjectContext
    
    init() {
        viewContext = storageProvider.persistentContainer.viewContext
        searchContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        searchContext.parent = viewContext
    }
    
    func addBook(_ bookToAdd: BookRes) {
        let newBook = storageProvider.addBook(bookToAdd, context: searchContext)
        newBooks.append(newBook)
    }
    
    func removeBookWithTitle(_ title: String) {
        guard let newBook = newBooks.first(where: { $0.title == title}) else { return }
        storageProvider.removeBook(newBook, context: searchContext)
    }
    
    func complete() {
        do {
            try searchContext.save()
        } catch {
        }
    }
    
    func getSearchResults() async {
        isLoading.toggle()
        searchResult = await NetworkManager.shared.searchData(with: keyword)
        isLoading.toggle()
    }
}
