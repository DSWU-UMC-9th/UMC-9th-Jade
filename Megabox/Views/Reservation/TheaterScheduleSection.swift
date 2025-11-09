//
//  TheaterScheduleSection.swift
//  Megabox
//
//  Created by Jung Hyun Han on 11/5/25.
//

import SwiftUI

struct TheaterScheduleSection: View {
    @ObservedObject var vm: ReservationViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 21) {
            if vm.showScreenInfo {
                ForEach(vm.filteredSchedules, id: \.name) { area in
                    VStack(alignment: .leading, spacing: 21) {
                        Text(area.name)
                            .font(.bold18)

                        ForEach(area.items, id: \.name) { item in
                            VStack(alignment: .leading, spacing: 21) {
                                HStack {
                                    Text(item.name)
                                        .font(.bold18)
                                    Spacer()
                                    Text(item.format)
                                        .font(.semiBold14)
                                }

                                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 36), count: 3), spacing: 19) {
                                    ForEach(item.showtimes, id: \.start) { showtime in
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(showtime.start)
                                                .font(.bold18)
                                            Text("~\(showtime.end)")
                                                .font(.regular12)
                                                .foregroundColor(.gray03)
                                            HStack(spacing: 0) {
                                                Text("\(showtime.available)")
                                                    .font(.semiBold14)
                                                    .foregroundColor(.purple03)
                                                Text(" / \(showtime.total)")
                                                    .font(.semiBold14)
                                                    .foregroundColor(.gray03)
                                            }
                                        }
                                        .frame(maxWidth: .infinity)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 14)
                                        .background(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color.gray02)
                                        )
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                emptyState
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 50)
    }

    private var emptyState: some View {
        VStack(spacing: 8) {
            Image(systemName: "film")
                .font(.bold18)
                .foregroundStyle(.gray)
            Text("선택한 극장에 상영시간표가 없습니다")
                .font(.medium14)
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity, minHeight: 200)
    }
}
