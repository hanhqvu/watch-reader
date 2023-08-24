//
//  BookListView.swift
//  WatchReader App
//
//  Created by Hanh Vu on 2023/08/24.
//

import SwiftUI

struct BookListView: View {
    @FetchRequest var bookList: FetchedResults<Book>
    @State private var showDetail: Bool = false
    let title: String
    
    init(status: Status) {
        _bookList = FetchRequest<Book>(sortDescriptors: [], predicate: NSPredicate(format: "%K = %@", argumentArray: [#keyPath(Book.status), status.rawValue]))
        self.title = status.rawValue
        print(status)
    }
    
    var body: some View {
        List(bookList) { book in
            BookItemView(book: book)
                .sheet(isPresented: $showDetail) {
                    DetailView(viewModel: DetailViewModel(sourceBook: book), showDetail: $showDetail)
                }
        }
        .listStyle(.carousel)
        .navigationTitle(title)
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView(status: .reading)
    }
}
