//
//  TheatherButton.swift
//  Megabox
//
//  Created by Jung Hyun Han on 10/12/25.
//

import SwiftUI

struct TheaterButton: View {
    let title: String
    let isEnabled: Bool
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.semiBold16)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(
                    Capsule()
                        .fill(isSelected ? Color.purple03 : Color.gray01)
                )
                .foregroundStyle(isSelected ? Color.white : Color.gray05)
        }
        .animation(.easeInOut(duration: 0.15), value: isSelected)
        .animation(.easeInOut(duration: 0.15), value: isEnabled)
    }
}
