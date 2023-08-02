//
//  ContentView.swift
//  WatchReader WatchKit Extension
//
//  Created by Hanh Vu on 2022/08/18.
//

import SwiftUI

struct CurrentListView: View {
    @State var bookList: [Book] = []
    @State private var showSearch: Bool = false
    
    var body: some View {
        BookListView(bookList: $bookList)
            .sheet(isPresented: $showSearch) {
                SearchListView(showSearch: $showSearch)
            }
            .navigationTitle("Currently Reading")
            .toolbar{
                Button(role: .none) {
                    showSearch.toggle()
                } label: {
                    Label("Add book", systemImage: "plus")
                }
            }
    }
}
