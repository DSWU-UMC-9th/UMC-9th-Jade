//
//  TheaterViewModel.swift
//  Megabox
//
//  Created by Jung Hyun Han on 11/5/25.
//

import Combine
import Foundation

class TheaterViewModel {
    @Published var selectedMovie: String? = nil
    @Published var selectedTheater: String? = nil
    @Published var selectedDate: Date? = nil
    
    @Published var showTimes: [ShowTime] = []
    @Published var message: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        Publishers.CombineLatest3($selectedMovie, $selectedTheater, $selectedDate)
            .sink { [weak self] movie, theater, date in
                guard let self else { return }
                self.updateShowTimes(movie: movie, theater: theater, date: date)
            }
            .store(in: &cancellables)
    }
    
    private func updateShowTimes(movie: String?, theater: String?, date: Date?) {
        guard let movie, let theater, let date else {
            showTimes = []
            message = nil
            return
        }
        
        let today = Calendar.current.startOfDay(for: Date())
        let selectedDay = Calendar.current.startOfDay(for: date)
        
        if selectedDay != today {
            showTimes = []
            message = "선택한 극장에 상영시간표가 없습니다"
            return
        }
        
        switch theater {
        case "강남":
            showTimes = [
                ShowTime(location: "크리클라이너 1관", times: ["11:30", "14:20", "17:05", "19:45", "22:20"])
            ]
            message = nil
            
        case "홍대":
            showTimes = [
                ShowTime(location: "BTS관 (7층 1관 [Laser])", times: ["9:30", "12:00", "14:45"]),
                ShowTime(location: "BTS관 (9층 2관 [Laser])", times: ["11:30", "14:10", "16:50", "19:20"])
            ]
            message = nil
            
        default:
            showTimes = []
            message = "선택한 극장에 상영시간표가 없습니다"
        }
    }
}

struct ShowTime: Identifiable {
    let id = UUID()
    let location: String
    let times: [String]
}
