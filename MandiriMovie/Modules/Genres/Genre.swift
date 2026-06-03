//
//  Genre.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 03/06/26.
//

import Foundation

struct Genre: Decodable {
    let id: Int
    let name: String
}

struct GenreResponse: Decodable {
    let genres: [Genre]
}
