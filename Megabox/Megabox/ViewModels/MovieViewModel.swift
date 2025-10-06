//
//  MovieViewModel.swift
//  Megabox
//
//  Created by Jung Hyun Han on 10/6/25.
//

import Foundation
import Observation

@Observable
class MovieViewModel{
let movies: [MovieModel] = [
    .init(movieImage: "noOtherChoice", movieName: "어쩔수가 없다", movieSpectator: 20),
    .init(movieImage: "infinityCastle", movieName: "귀멸의 칼날", movieSpectator: 123),
    .init(movieImage: "f1", movieName: "F1 더 무비", movieSpectator: 45),
    .init(movieImage: "face", movieName: "얼굴", movieSpectator: 678),
    .init(movieImage: "princessMononoke", movieName: "원령 공주", movieSpectator: 910),
    .init(movieImage: "boss", movieName: "보스", movieSpectator: 1112),
    .init(movieImage: "theSnitch", movieName: "야당", movieSpectator: 131415),
    .init(movieImage: "theRoses", movieName: "완벽한 이혼", movieSpectator: 1617),
    ]
}
