//
//  DateSelectionSection.swift
//  Megabox
//
//  Created by Jung Hyun Han on 11/1/25.
//

import SwiftUI

struct DateSelectionSection: View {
    @ObservedObject var vm: ReservationViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 5) {
                ForEach(vm.weekDays) { day in
                    let isSelected = vm.selectedDate.map {
                        Calendar.current.isDate($0, inSameDayAs: day.date)
                    } ?? false
                    
                    VStack(spacing: 4) {
                        if isSelected {
                            Text("11.\(day.dayNumber)")
                                .font(.bold18)
                            Text(day.dayLabel)
                                .font(.semiBold14)
                        } else {
                            Text(day.dayNumber)
                                .font(.bold18)
                            Text(day.dayLabel)
                                .font(.semiBold14)
                        }
                    }
                    .foregroundColor(textColor(for: day, isSelected: isSelected))
                    .frame(width: 55, height: 60)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(isSelected ? Color.purple03 : Color.clear)
                    )
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            vm.selectDate(day.date)
                        }
                    }
     
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 10)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
    private func textColor(for day: WeekDay, isSelected: Bool) -> Color {
        if isSelected { return .white }
        switch day.weekday {
        case 1: return .holiday
        case 7: return .tag
        default: return .gray03
        }
    }
}
