//
//  MovieModel.swift
//  Megabox
//
//  Created by Jung Hyun Han on 10/6/25.
//

import Foundation

struct MovieModel: Identifiable, Hashable {
    let id = UUID()
    let movieImage: String
    let movieName: String
    let movieSpectator: Int
    
    var audienceText: String { "누적관객수 \(movieSpectator.formatted())" }
}

