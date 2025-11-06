//
//  MovieSchedulViewModel.swift
//  Megabox
//
//  Created by Jung Hyun Han on 11/6/25.
//

import Foundation

@MainActor
final class MovieScheduleViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func loadMovieSchedules() async {
        isLoading = true
        errorMessage = nil

        guard let url = Bundle.main.url(forResource: "MovieSchedule", withExtension: "json") else {
            errorMessage = "MovieSchedule.json 파일을 찾을 수 없습니다."
            isLoading = false
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode(MovieScheduleResponseDTO.self, from: data)
            let mappedMovies = decoded.data.movies.map { MovieMapper.toDomain(from: $0) }
            movies = mappedMovies
            isLoading = false
        } catch {
            errorMessage = "JSON 디코딩 중 오류 발생: \(error.localizedDescription)"
            isLoading = false
            print("Decoding error:", error)
        }
    }
}
