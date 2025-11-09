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

final class ReservationViewModel: ObservableObject {
    @Published var selectedMovie: MovieModel? = nil
    @Published var selectedTheaters: [String] = []
    @Published var selectedDate: Date? = nil
    @Published var weekDays: [WeekDay] = []
    @Published var showScreenInfo = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        generateWeekDays()
        setupBindings()
    }
    
    private func setupBindings() {
        Publishers.CombineLatest3($selectedMovie, $selectedTheaters, $selectedDate)
            .map { movie, theaters, date in
                return movie != nil && !theaters.isEmpty && date != nil
            }
            .assign(to: &$showScreenInfo)
    }
    
    func toggleTheater(_ theater: String) {
        if selectedTheaters.contains(theater) {
            selectedTheaters.removeAll { $0 == theater }
        } else {
            selectedTheaters.append(theater)
        }
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
        guard !selectedTheaters.isEmpty else { return }
        selectedDate = date
    }
}
