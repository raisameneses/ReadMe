//
//  Book.swift
//  ReadMe
//
//  Created by Raisa Meneses on 3/24/21.
//

import UIKit

public struct Book : Hashable {
    let title: String
    let author: String
    var review: String?
    var readMe: Bool
    var image: UIImage?
    
    static let mockBook = Book(title: "", author: "",  readMe: true)
}

extension Book: Codable {
    enum CodingKeys: String, CodingKey {
        case title
        case author
        case review
        case readMe
    }
}
