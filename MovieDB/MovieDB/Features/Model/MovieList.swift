//
//  MovieList.swift
//  MovieDB
//
//  Created by Teja Bethina on 6/1/21.
//

struct MoviesList: Codable {
    var results: [Movie] = []
}

struct Movie: Codable {
    var original_title = ""
    var overview = ""
    var release_date = ""
    var poster_path = ""
    var vote_average = 0.0
}
