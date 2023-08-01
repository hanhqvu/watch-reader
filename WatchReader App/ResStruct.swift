//
//  ResStruct.swift
//  WatchReader WatchKit Extension
//
//  Created by Hanh Vu on 2022/08/26.
//

import Foundation

struct BookRes: Codable {
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
}

struct SearchRes: Codable {
    var docs: [BookRes]
}

enum status {
    case reading
    case read
    case abandoned
}

struct Book {
    let id: String
    let title: String
    let author: [String]
    let imageKey: String
    var status: status
    var rating: Int?
}
