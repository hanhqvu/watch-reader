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
    @Published var bookList: [Book] = []
    let viewContext = StorageProvider.shared.persistentContainer.viewContext
    let searchContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    init() {
        searchContext.parent = viewContext
    }
    
    func addBook(_ bookToAdd: BookRes) {
        let book = BookEntity(context: searchContext)
        book.title = bookToAdd.title
        book.status = "Reading"
        book.imageKey = bookToAdd.imageKey
        book.summary = bookToAdd.title
        
        do {
            try searchContext.save()
            print("Book added succesfully")
        } catch {
            print("Failed to add book: \(error)")
        }
    }
    
    func dismiss() {
        keyword = ""
        searchResult = []
    }
    
    func complete() {
        do {
            try viewContext.save()
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
