//
//  SearchView.swift
//  WatchReader WatchKit Extension
//
//  Created by Hanh Vu on 2022/08/26.
//

import SwiftUI

struct SearchListView: View {
    @State var search: String = ""
    @State var searchResult: [BookRes] = []
    @State var isLoading: Bool = false
    @Binding var bookList: [Book]
    @Binding var showSearch: Bool
    
    var body: some View {
            List {
                if (isLoading) {
                    ProgressView("Loading")
                } else {
                    ForEach(0..<searchResult.count, id: \.self) { index in
                        SearchItemView(bookRes: searchResult[index], bookList: $bookList)
                    }
                    .listRowBackground(Color(red: 0.98, green: 0.929, blue: 0.804))
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        search = ""
                        searchResult = []
                        showSearch.toggle()
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    TextField("Search with title", text: $search) {
                    }
                    .onSubmit {
                        Task {
                            await searchData()
                        }
                    }
                }
            }
            .listStyle(.carousel)
            .navigationTitle("Search")
            .navigationViewStyle(.stack)
    }
    
    func searchData() async {
        isLoading.toggle()
        guard let url = URL(string: "https://openlibrary.org/search.json?q=\(search.replacingOccurrences(of: " ", with: "+"))") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let search: SearchRes = try! JSONDecoder().decode(SearchRes.self, from: data)
            searchResult = search.docs.filter { book in
                return book.imageKey != nil
            }
            isLoading.toggle()
        } catch {
            print("Invalid data")
        }
    }
}
