//
//  ContentView.swift
//  WatchReader WatchKit Extension
//
//  Created by Hanh Vu on 2022/08/18.
//

import SwiftUI

struct CurrentListView: View {
    @FetchRequest(fetchRequest: Book.readingByProgress)
    var bookList: FetchedResults<Book>
    @State private var showSearch: Bool = false
    
    var body: some View {
        NavigationStack {
            List(bookList) { book in
                NavigationLink(value: book) {
                    BookItemView(title: book.title!, key: book.imageKey!)
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                book.bookStatus = .abandoned
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.large)
                            }
                        }
                        .swipeActions(edge: .leading) {
                            Button(role: .none) {
                                book.bookStatus = .finished
                            } label: {
                                Image(systemName: "checkmark.circle.fill")
                                    .imageScale(.large)
                            }
                            .tint(.green)
                        }
                }
                .listRowBackground(Color(red: 0.98, green: 0.929, blue: 0.804))
            }
            .listStyle(.carousel)
            .navigationTitle("Reading")
            .navigationDestination(for: Book.self) { book in
                DetailView(viewModel: DetailViewModel(sourceBook: book))
            }
            .toolbar{
                Button(role: .none) {
                    showSearch.toggle()
                } label: {
                    Label("Add book", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showSearch) {
            SearchView(showSearch: $showSearch)
        }
    }
}
