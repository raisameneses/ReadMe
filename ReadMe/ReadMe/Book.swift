//
//  Book.swift
//  ReadMe
//
//  Created by Raisa Meneses on 3/24/21.
//

import UIKit

public struct Book {
    let title: String
    let author: String
    var review: String?
    var image: UIImage {
        Library.loadImage(forBook: self)
        ??  LibrarySymbol.letterSquare(letter: title.first).image
    }
}
