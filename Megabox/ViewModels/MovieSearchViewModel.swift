//
//  MovieSearchViewModel.swift
//  Megabox
//
//  Created by Jung Hyun Han on 11/5/25.
//

import SwiftUI
import Combine

final class MovieSearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var filteredMovies: [MovieModel] = []

    private var cancellables = Set<AnyCancellable>()

    init(allMovies: [MovieModel]) {
        $searchText
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .removeDuplicates()
            .map { query in
                query.isEmpty ? allMovies :
                allMovies.filter { $0.movieName.contains(query) }
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$filteredMovies)
    }
}
