//
//  SearchView.swift
//  WatchReader WatchKit Extension
//
//  Created by Hanh Vu on 2022/08/26.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = SearchViewModel()
    @Binding var showSearch: Bool
    
    var body: some View {
        List {
            if (viewModel.isLoading) {
                ProgressView("Loading")
            } else {
                ForEach($viewModel.searchResult) { $result in
                    SearchItemView(bookRes: $result)
                        .onChange(of: result.listStatus) { newStatus in
                            if (newStatus == .pending) {
                                viewModel.newBooks.append(viewModel.addBook(result))
                            } else {
                                guard let newBook = viewModel.newBooks.first(where: { $0.title == result.title}) else { return }
                                viewModel.removeBook(newBook)
                            }
                        }
                }
                .listRowBackground(Color(red: 0.98, green: 0.929, blue: 0.804))
            }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    viewModel.complete()
                    showSearch.toggle()
                }
            }
            ToolbarItem(placement: .primaryAction) {
                TextField("Search with title", text: $viewModel.keyword) {
                }
                .onSubmit {
                    Task {
                        await viewModel.getSearchResults()
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
