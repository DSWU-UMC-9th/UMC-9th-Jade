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
            if vm.showScreenInfo,
               !vm.selectedTheaters.isEmpty,
               let selectedDate = vm.selectedDate {
                
                if Calendar.current.isDateInToday(selectedDate) {
                    ForEach(vm.selectedTheaters, id: \.self) { theater in
                        switch theater {
                        case "강남":
                            theaterInfo(title: "강남", screens: [
                                ("크리클라이너 1관", [
                                    ("11:30", "~13:58", "109 / 116"),
                                    ("14:20", "~16:48", "19 / 116"),
                                    ("17:05", "~19:28", "01 / 116"),
                                    ("19:45", "~22:02", "100 / 116"),
                                    ("22:20", "~00:04", "116 / 116")
                                ])
                            ])
                        case "홍대":
                            theaterInfo(title: "홍대", screens: [
                                ("BTS관 (7층 1관 [Laser])", [
                                    ("9:30", "~11:50", "75 / 116"),
                                    ("12:00", "~14:26", "102 / 116"),
                                    ("14:45", "~17:04", "88 / 116")
                                ]),
                                ("BTS관 (9층 2관 [Laser])", [
                                    ("11:30", "~13:58", "34 / 116"),
                                    ("14:10", "~16:32", "100 / 116"),
                                    ("16:50", "~19:00", "13 / 116"),
                                    ("19:20", "~21:40", "92 / 116")
                                ])
                            ])
                        default:
                            emptyState
                        }
                    }
                } else {
                    emptyState
                }
            } else {
                EmptyView()
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 50)
    }
    
    private func theaterInfo(title: String, screens: [(String, [(String, String, String)])]) -> some View {
        VStack(alignment: .leading, spacing: 21) {
            Text(title)
                .font(.bold18)
            
            ForEach(screens, id: \.0) { screen in
                VStack(alignment: .leading, spacing: 21) {
                    HStack {
                        Text(screen.0)
                            .font(.bold18)
                        Spacer()
                        Text("2D")
                            .font(.semiBold14)
                    }
                    
                    LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 36), count: 3), spacing: 19) {
                        ForEach(screen.1, id: \.0) { time in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(time.0)
                                    .font(.bold18)
                                Text(time.1)
                                    .font(.regular12)
                                    .foregroundColor(.gray03)
                                HStack(spacing: 0) {
                                    let parts = time.2.split(separator: "/")
                                    if parts.count == 2 {
                                        Text("\(parts[0])") // 남은 좌석 수
                                            .font(.semiBold14)
                                            .foregroundColor(.purple03)
                                        Text(" / \(parts[1])") // 전체 좌석
                                            .font(.semiBold14)
                                            .foregroundColor(.gray03)
                                    } else {
                                        Text(time.2)
                                            .font(.semiBold14)
                                            .foregroundColor(.gray03)
                                    }
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


import SwiftUI

struct TheaterScheduleSection_Previews: PreviewProvider {
    static var previews: some View {
        // ✅ Preview용 ViewModel 인스턴스 생성
        let previewVM = ReservationViewModel()
        
        // ✅ 예매 섹션 표시 조건 충족시키기
        previewVM.selectedMovie = MovieModel(movieImage: "f1", movieName: "서울의 봄", movieSpectator: 1)
        previewVM.selectedTheaters = ["강남", "홍대"] // 여러 극장 선택
        previewVM.selectedDate = Date()               // 오늘 날짜로 설정
        
        // ✅ Combine 연동된 showScreenInfo도 true로 업데이트됨
        return TheaterScheduleSection(vm: previewVM)
            .padding()
            .previewLayout(.sizeThatFits)
            .background(Color.white)
            .previewDisplayName("상영관 섹션 미리보기 (강남 + 홍대)")
    }
}
