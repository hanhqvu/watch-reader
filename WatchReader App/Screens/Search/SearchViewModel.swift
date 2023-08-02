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
    
    func dismiss() {
        keyword = ""
        searchResult = []
    }
    
    func getSearchResults() async {
        isLoading.toggle()
        searchResult = await NetworkManager.shared.searchData(with: keyword)
        isLoading.toggle()
    }
}
