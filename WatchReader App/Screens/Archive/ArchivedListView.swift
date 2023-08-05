//
//  ArchivedListView.swift
//  WatchReader App
//
//  Created by Hanh Vu on 2023/08/06.
//

import SwiftUI

struct ArchivedListView: View {
    @FetchRequest(fetchRequest: Book.readByProgress)
    var bookList: FetchedResults<Book>
    
    var body: some View {
        List {
            ForEach(bookList, id: \.self) { book in
                NavigationLink(destination: DetailView(book: book)) {
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
        }
        .listStyle(.carousel)
    }
}

struct ArchivedListView_Previews: PreviewProvider {
    static var previews: some View {
        ArchivedListView()
    }
}
