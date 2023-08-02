//
//  NetworkManager.swift
//  WatchReader App
//
//  Created by Hanh Vu on 2023/08/02.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let baseURL = "https://openlibrary.org/"
    
    private init() {
        
    }
    
    func searchData(with keyword: String) async -> [BookRes] {
        guard let url = URL(string: baseURL + "search.json?q=\(keyword.replaceSpaceWithPlus())") else {
            print("Invalid URL")
            return []
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let search: SearchRes = try! JSONDecoder().decode(SearchRes.self, from: data)
            return search.docs.filter { book in
                return book.imageKey != nil
            }
        } catch {
            print("Invalid data")
            return []
        }
    }
}
