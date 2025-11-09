//
//  MovieDetailModel.swift
//  Megabox
//
//  Created by Jung Hyun Han on 10/7/25.
//

import Foundation

struct MovieDetailModel: Identifiable {
    let id = UUID()
    let poster: String
    let titleKo: String
    let titleEn: String
    let description: String
    let posterImage: String
    let age: String
    let releaseDate: String
}
