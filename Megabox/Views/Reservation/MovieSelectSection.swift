//
//  MovieSelectSection.swift
//  Megabox
//
//  Created by Jung Hyun Han on 10/11/25.
//

import SwiftUI

struct MovieSelectSection: View {
    @ObservedObject var vm: MovieViewModel
    @Binding var selectedMovie: MovieModel?

    var title: String = ""
    var showAllAction: (() -> Void)? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 37) {
                Image("15")
                Text(selectedMovie?.movieName ?? (title.isEmpty ? "영화 선택" : title))
                    .font(.system(size: 18, weight: .bold))
                Spacer()
                if let showAllAction {
                    Button("전체영화", action: showAllAction)
                        .font(.semiBold14)
                        .foregroundStyle(Color.black)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .overlay {
                            Capsule().stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        }
                }
            }
            .padding(.horizontal, 16)

            // 포스터 리스트
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(vm.movieViewModel) { movie in
                        MovieCard(
                            imageName: movie.movieImage,
                            title: movie.movieName,
                            isSelected: movie == selectedMovie
                        )
                        .onTapGesture { selectedMovie = movie }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 20)
            }
        }
    }
}

// 카드
private struct MovieCard: View {
    let imageName: String
    let title: String
    let isSelected: Bool

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(width: 62, height: 89)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? .purple03 : .clear, lineWidth: 2)
            }
    }
}
