//
//  MovieDetailView.swift
//  Megabox
//
//  Created by Jung Hyun Han on 10/7/25.
//

import SwiftUI

struct MovieDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let movie: MovieDetailModel
    var viewModel = MovieDetailViewModel()

    @State private var selectedTab: Tab = .detail
    @Namespace private var ns

    enum Tab: String { case detail = "상세 정보", review = "실관람평" }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Header
                MovieInfo
                Spacer()
                SegmentSection
            }
        }
    }
    
    private var Header: some View {
        HStack {
            Text(movie.titleKo)
                .font(.semiBold16)
                .foregroundStyle(.black)
        }
        .padding(.bottom, 20)
    }
    private var MovieInfo: some View {
        VStack(spacing: 9) {
            Image(movie.poster)

            VStack(alignment: .leading, spacing: 0) {
                Text(movie.titleKo)
                    .font(.bold24)
                Text(movie.titleEn)
                    .font(.semiBold14)
                    .foregroundStyle(.gray03)
            }

            Text(movie.description)
                .font(.semiBold18)
                .foregroundStyle(.gray03)
                .padding(.horizontal, 16)
        }
        .padding(.horizontal, 16)
    }
    private var SegmentSection: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    segBtn(.detail)
                    Spacer()
                    segBtn(.review)
                    Spacer()
                }
            }
            ZStack {
                Rectangle()
                    .fill(.gray02)
                    .frame(height: 2)
                
                GeometryReader { geo in
                    let barW = geo.size.width / 2
                    
                    HStack {
                        if selectedTab == .detail {
                            Rectangle()
                                .fill(.black)
                                .frame(width: barW, height: 2)
                                .matchedGeometryEffect(id: "bar", in: ns)
                            Spacer()
                        } else {
                            Spacer()
                            Rectangle()
                                .fill(.black)
                                .frame(width: barW, height: 2)
                                .matchedGeometryEffect(id: "bar", in: ns)
                        }
                    }
                }
                .frame(height: 2)
            }
            .padding(.vertical, 10)
            
            if selectedTab == .detail {
                VStack {
                    HStack(alignment: .top, spacing: 12) {
                        Image(movie.posterImage)
                            .resizable()
                            .frame(width: 100, height: 120)
                        
                        VStack(alignment: .leading, spacing: 9) {
                            Text(movie.age)
                                .font(.semiBold13)
                                .foregroundStyle(.black)
                            Text(movie.releaseDate)
                                .font(.semiBold13)
                                .foregroundStyle(.black)
                        }
                        Spacer()
                    }
                }
                .padding(.horizontal, 45)
            } else {
                Text("등록된 관람평이 없어요 🥲")
                    .font(.semiBold18)
                    .foregroundStyle(.gray08)
                    .frame(maxWidth: .infinity, minHeight: 140)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.purple02), lineWidth: 1)
                    }
                    .padding(.horizontal, 45)
            }
        }
    }

    private func segBtn(_ tab: Tab) -> some View {
        Button {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.9)) {
                selectedTab = tab
            }
        } label: {
            Text(tab.rawValue)
                .font(.bold22)
                .foregroundStyle(selectedTab == tab ? .black : .gray02)
        }
    }
}

#Preview {
    MovieDetailView(
        movie: MovieDetailModel(
            poster: "f1Detail",
            titleKo: "F1 더 무비",
            titleEn: "F1 : The Movie",
            description: """
            최고가 되지 못한 전설 VS 최고가 되고 싶은 루키

            한때 주목받는 유망주였지만 끔찍한 사고로 F1에서 우승하지 못하고
            한순간에 추락한 드라이버 ‘손; 헤이스’(브래드 피트).
            그의 오랜 동료 ‘루벤 세르반테스’(하비에르 바르뎀)에게
            레이싱 복귀를 제안받으며 최하위 팀인 APXGP에 합류한다.
            """,
            posterImage: "f1Poster",
            age: "12세 이상 관람가",
            releaseDate: "2025.06.25 개봉"
        )
    )
}

