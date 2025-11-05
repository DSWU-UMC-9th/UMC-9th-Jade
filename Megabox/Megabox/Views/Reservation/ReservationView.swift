//
//  ReservationView.swift
//  Megabox
//
//  Created by Jung Hyun Han on 10/11/25.
//

import SwiftUI

struct ReservationView: View {
    @StateObject private var vm = MovieViewModel()
    @StateObject private var reservationVM = ReservationViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    MovieSelectSection(
                        vm: vm,
                        selectedMovie: $reservationVM.selectedMovie,
                        title: "어쩔수가 없다"
                    ) { }
                    .padding(.top, 16)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        TheaterSelectSection(vm: reservationVM)
                        DateSelectionSection(vm: reservationVM)
                        TheaterScheduleSection(vm: reservationVM)
                    }
                    .padding(.bottom, 40)
                }
            }
            .navigationTitle("영화별 예매")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.purple03, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}

#Preview { ReservationView() }
