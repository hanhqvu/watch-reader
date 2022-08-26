//
//  BookListView.swift
//  WatchReader WatchKit Extension
//
//  Created by Hanh Vu on 2022/08/26.
//

import SwiftUI

struct BookListView: View {
    @Binding var bookList: [Book]
    @State var showDetail: Bool = false
    
    var body: some View {
            List {
                if (!bookList.isEmpty) {
                    ForEach(0..<bookList.count, id: \.self) { index in
                        BookItemView(title: bookList[index].title, key: bookList[index].imageKey)
                            .swipeActions(edge: .leading) {
                                Button(role: .none) {
                                    showDetail.toggle()
                                } label: {
                                    Label("Read", systemImage: "ellipsis")
                                }
                                .tint(.green)
                            }
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    bookList.remove(at: index)
                                } label: {
                                    Label("Remove", systemImage: "trash")
                                }
                            }
                            .sheet(isPresented: $showDetail) {
                                DetailView(book: $bookList[index], showDetail: $showDetail)
                            }
                    }
                    .listRowBackground(Color(red: 0.98, green: 0.929, blue: 0.804))
                }
            }
            .listStyle(.carousel)
    }
}
