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
    @State private var showDetail: Bool = false
    
    var body: some View {
        NavigationStack {
            List(bookList) { book in
                BookItemView(book: book)
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
                    .onTapGesture {
                        showDetail.toggle()
                    }
                    .sheet(isPresented: $showDetail) {
                        DetailView(viewModel: DetailViewModel(sourceBook: book), showDetail: $showDetail)
                    }
            }
            .listStyle(.carousel)
            .navigationTitle("Reading")
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
