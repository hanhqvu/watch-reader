//
//  BookListView.swift
//  WatchReader WatchKit Extension
//
//  Created by Hanh Vu on 2022/08/26.
//

import SwiftUI

struct BookListView: View {
    @Binding var bookList: [BookEntity]
    @State var showDetail: Bool = false
    
    var body: some View {
            List {
                if (!bookList.isEmpty) {
                    ForEach(0..<bookList.count, id: \.self) { index in
                        NavigationLink(destination: DetailView(book: $bookList[index])) {
                            BookItemView(title: bookList[index].title!, key: bookList[index].imageKey!)
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        bookList.remove(at: index)
                                    } label: {
                                        Label("Remove", systemImage: "trash")
                                    }
                                }
                        }
                    }
                    .listRowBackground(Color(red: 0.98, green: 0.929, blue: 0.804))
                }
            }
            .listStyle(.carousel)
    }
}
