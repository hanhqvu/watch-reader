//
//  SearchView.swift
//  WatchReader WatchKit Extension
//
//  Created by Hanh Vu on 2022/08/26.
//

import SwiftUI

struct SearchListView: View {
    @StateObject var searchViewModel = SearchViewModel(showSearch: false)
    
    var body: some View {
            List {
                if (searchViewModel.isLoading) {
                    ProgressView("Loading")
                } else {
                    ForEach(0..<searchViewModel.searchResult.count, id: \.self) { index in
                        SearchItemView(bookRes: searchViewModel.searchResult[index], bookList: $searchViewModel.bookList)
                    }
                    .listRowBackground(Color(red: 0.98, green: 0.929, blue: 0.804))
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        searchViewModel.dismiss()
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    TextField("Search with title", text: $searchViewModel.keyword) {
                    }
                    .onSubmit {
                        Task {
                            await searchViewModel.getSearchResults()
                        }
                    }
                }
            }
            .listStyle(.carousel)
            .navigationTitle("Search")
            .navigationViewStyle(.stack)
    }
}
