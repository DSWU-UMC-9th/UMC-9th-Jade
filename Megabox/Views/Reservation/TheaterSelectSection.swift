//
//  TheaterSelectSection.swift
//  Megabox
//
//  Created by Jung Hyun Han on 11/5/25.
//

import SwiftUI

struct TheaterSelectSection: View {
    @ObservedObject var vm: ReservationViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(["강남", "홍대", "신촌"], id: \.self) { theater in
                TheaterButton(
                    title: theater,
                    isEnabled: vm.selectedMovie != nil,
                    isSelected: vm.selectedTheaters.contains(theater)
                ) {
                    vm.toggleTheater(theater)
                }
            }
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 8)
    }
}
