//
//  MovieSearchView.swift
//  Megabox
//
//  Created by Jung Hyun Han on 11/5/25.
//

import SwiftUI
import Combine

struct MovieSearchView: View {
    @ObservedObject var vm: MovieSearchViewModel
    var onSelect: (MovieModel) -> Void
    @Environment(\.dismiss) private var dismiss

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 24) {
                    ForEach(vm.filteredMovies) { movie in
                        VStack(spacing: 8) {
                            Image(movie.movieImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 140)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            Text(movie.movieName)
                                .font(.system(size: 13, weight: .medium))
                                .lineLimit(1)
                        }
                        .onTapGesture { onSelect(movie) }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 24)
                .padding(.bottom, 80)
            }

            HStack(spacing: 10) {
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray03)

                    TextField("영화명을 입력해주세요", text: $vm.searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(.system(size: 14))
                        .autocorrectionDisabled(true)

                    Button {
                    } label: {
                        Image(systemName: "mic.fill")
                            .foregroundColor(.gray03)
                    }
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(Color(.systemGray6))
                .cornerRadius(20)

                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 22))
                        .foregroundColor(.gray03)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 12)
        }
        .navigationTitle("영화 선택")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.white)
    }
}

#Preview {
    let movies = [
        MovieModel(movieImage: "f1Poster", movieName: "F1 더 무비", movieSpectator: 12),
        MovieModel(movieImage: "demonSlayer", movieName: "귀멸의 칼날", movieSpectator: 12),
        MovieModel(movieImage: "noOtherChoice", movieName: "어쩔 수가 없다.", movieSpectator: 15),
        MovieModel(movieImage: "princessMononoke", movieName: "원령 공주", movieSpectator: 12),
        MovieModel(movieImage: "face", movieName: "얼굴", movieSpectator: 15),
        MovieModel(movieImage: "boss", movieName: "보스", movieSpectator: 12),
        MovieModel(movieImage: "theRoses", movieName: "귀멸의 칼날", movieSpectator: 12)
    ]
    MovieSearchView(vm: MovieSearchViewModel(allMovies: movies)) { _ in }
}
