//
//  MovieModel.swift
//  Megabox
//
//  Created by Jung Hyun Han on 10/6/25.
//

import Foundation

struct MovieModel: Identifiable, Hashable {
    let id: UUID
    let movieImage: String
    let movieName: String
    let movieSpectator: Int

    init(
        id: UUID = UUID(),
        movieImage: String,
        movieName: String,
        movieSpectator: Int
    ) {
        self.id = id
        self.movieImage = movieImage
        self.movieName = movieName
        self.movieSpectator = movieSpectator
    }
    
    var audienceText: String { "누적관객수 \(movieSpectator.formatted())" }
}


