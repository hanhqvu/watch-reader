//
//  ResStruct.swift
//  WatchReader WatchKit Extension
//
//  Created by Hanh Vu on 2022/08/26.
//

import Foundation

enum ListStatus {
    case added, pending, none
}

struct BookRes: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case id = "key"
        case imageKey = "cover_edition_key"
        case authors = "author_name"
    }
    
    var id: String
    var title: String
    var imageKey: String?
    var authors: [String]?
    var listStatus: ListStatus = .none
}

struct SearchRes: Codable {
    var docs: [BookRes]
}

enum Status: String, CaseIterable {
    case reading = "Reading"
    case finished = "Finished"
    case abandoned = "Abandoned"
}
