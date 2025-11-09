//
//  ReservationViewModel.swift
//  Megabox
//
//  Created by Jung Hyun Han on 11/5/25.
//

import SwiftUI
import Combine

struct WeekDay: Identifiable, Equatable {
    let id = UUID()
    let date: Date
    let dayNumber: String
    let dayLabel: String
    let isToday: Bool
    let weekday: Int
}

@MainActor
final class ReservationViewModel: ObservableObject {
    @Published var allMovies: [Movie] = []
    @Published var selectedMovie: MovieModel? = nil
    @Published var selectedTheaters: [String] = []
    @Published var selectedDate: Date? = nil
    @Published var weekDays: [WeekDay] = []
    @Published var filteredSchedules: [Area] = []
    @Published var showScreenInfo = false
    
    private var cancellables = Set<AnyCancellable>()

    init() {
        generateWeekDays()
        setupBindings()
        Task {
            await loadMovieSchedules()
            autoSelectLatestDate()
        }
    }

    private func setupBindings() {
        Publishers.CombineLatest3($selectedMovie, $selectedTheaters, $selectedDate)
            .sink { [weak self] _, _, _ in
                self?.applyFilter()
            }
            .store(in: &cancellables)
    }

    func toggleTheater(_ theater: String) {
        if selectedTheaters.contains(theater) {
            selectedTheaters.removeAll { $0 == theater }
        } else {
            selectedTheaters.append(theater)
        }
        applyFilter()
    }

    func generateWeekDays() {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "E"
        
        weekDays = (0..<7).compactMap { offset in
            guard let date = calendar.date(byAdding: .day, value: offset, to: Date()) else { return nil }
            let weekday = calendar.component(.weekday, from: date)
            let label = offset == 0 ? "오늘" : offset == 1 ? "내일" : formatter.string(from: date)
            
            return WeekDay(
                date: date,
                dayNumber: "\(calendar.component(.day, from: date))",
                dayLabel: label,
                isToday: offset == 0,
                weekday: weekday
            )
        }
    }

    func selectDate(_ date: Date) {
        selectedDate = date
        applyFilter()
    }

    // MARK: - JSON 로드
    func loadMovieSchedules() async {
        guard let url = Bundle.main.url(forResource: "MovieSchedule", withExtension: "json") else {
            print("JSON 파일을 찾을 수 없습니다.")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode(MovieScheduleResponseDTO.self, from: data)
            allMovies = decoded.data.movies.map { MovieMapper.toDomain(from: $0) }
            print("JSON 로드 성공: \(allMovies.count)편")
        } catch {
            print("JSON 로드 실패:", error)
        }
    }

    // MARK: - 최신 날짜 자동 선택
    private func autoSelectLatestDate() {
        guard let latestDate = allMovies
            .flatMap({ $0.schedules.map { $0.date } })
            .sorted(by: >)
            .first else { return }
        selectedDate = latestDate
    }

    // MARK: - 필터링 로직
    private func applyFilter() {
        guard
            let selectedMovie = selectedMovie,
            let movie = allMovies.first(where: {
                $0.title.replacingOccurrences(of: " ", with: "") ==
                selectedMovie.movieName.replacingOccurrences(of: " ", with: "")
            }),
            let selectedDate = selectedDate
        else {
            filteredSchedules = []
            showScreenInfo = false
            return
        }

        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd"

        if let schedule = movie.schedules.first(where: {
            f.string(from: $0.date) == f.string(from: selectedDate)
        }) {
            let filteredAreas = schedule.areas.filter { area in
                selectedTheaters.contains { $0.contains(area.name) }
            }
            filteredSchedules = filteredAreas
            showScreenInfo = !filteredAreas.isEmpty
        } else {
            filteredSchedules = []
            showScreenInfo = false
        }
    }

}
