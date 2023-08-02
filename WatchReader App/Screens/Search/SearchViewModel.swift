//
//  SearchViewModel.swift
//  WatchReader App
//
//  Created by Hanh Vu on 2023/08/02.
//

import Foundation

final class SearchViewModel: ObservableObject {
    @Published var keyword: String = ""
    @Published var searchResult: [BookRes] = []
    @Published var isLoading: Bool = false
    @Published var bookList: [Book] = []
    @Published var showSearch: Bool
    
    init(showSearch: Bool) {
        self.showSearch = showSearch
    }
    
    func dismiss() {
        keyword = ""
        searchResult = []
        showSearch.toggle()
    }
    
    func getSearchResults() async {
        isLoading.toggle()
        searchResult = await NetworkManager.shared.searchData(with: keyword)
        isLoading.toggle()
    }
}
