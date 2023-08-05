//
//  SearchView.swift
//  WatchReader WatchKit Extension
//
//  Created by Hanh Vu on 2022/08/26.
//

import SwiftUI

struct SearchView: View {
    @StateObject var searchViewModel = SearchViewModel()
    @Binding var showSearch: Bool
    
    var body: some View {
            List {
                if (searchViewModel.isLoading) {
                    ProgressView("Loading")
                } else {
                    ForEach($searchViewModel.searchResult) { $result in
                        SearchItemView(bookRes: $result)
                    }
                    .listRowBackground(Color(red: 0.98, green: 0.929, blue: 0.804))
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        searchViewModel.complete()
                        showSearch.toggle()
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
                ToolbarItem(placement: .cancellationAction) {
                    Button("Dismiss") {
                        showSearch.toggle()
                    }
                }
            }
            .listStyle(.carousel)
            .navigationTitle("Search")
            .navigationViewStyle(.stack)
    }
}
