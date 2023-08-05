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
        case author = "author_name"
    }
    
    var id: String
    var title: String
    var imageKey: String?
    var author: [String]?
    var listStatus: ListStatus = .none
}

struct SearchRes: Codable {
    var docs: [BookRes]
}

enum Status: String {
    case reading = "Reading"
    case finished = "Finshed"
    case abandoned = "Abandoned"
}

struct Book {
    let id: String
    let title: String
    let author: [String]
    let imageKey: String
    var status: Status
    var rating: Int?
}
