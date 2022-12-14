//
//  ContentView.swift
//  WatchReader WatchKit Extension
//
//  Created by Hanh Vu on 2022/08/18.
//

import SwiftUI

struct ContentView: View {
    @State var bookList: [Book] = []
    @State private var showSearch: Bool = false
    
    var body: some View {
        BookListView(bookList: $bookList)
            .sheet(isPresented: $showSearch) {
                SearchListView(bookList: $bookList, showSearch: $showSearch)
            }
            .navigationTitle("WatchReader")
            .toolbar{
                Button(role: .none) {
                    showSearch.toggle()
                } label: {
                    Label("Add book", systemImage: "plus")
                }
            }
    }
}
