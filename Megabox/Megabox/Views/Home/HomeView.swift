//
//  HomeView.swift
//  Megabox
//
//  Created by Jung Hyun Han on 10/1/25.
//

import SwiftUI

struct HomeView: View {
    @State private var headerSelected = "홈"
    @State private var buttonSelected = "무비차트"
    @State private var movieModel = MovieViewModel()
    
    let headerTabs = ["홈", "이벤트", "스토어", "선호극장"]
    let movieTabs = ["무비차트", "상영예정"]
    
    var body: some View {
        ScrollView {
            VStack {
                Header
                Spacer()
                MovieButtons
                Spacer().frame(height: 25)
                MovieChart
                Spacer().frame(height: 38)
                MovieFeed
            }
            .padding(.horizontal, 18)
            .padding(.top, 22)
        }
    }
    
    private var Header: some View {
        VStack(alignment: .leading, spacing: 15) {
            Image("headerLogo")
            
            HStack(spacing: 24) {
                ForEach(headerTabs, id: \.self) { tab in
                    Text(tab)
                        .font(.semiBold24)
                        .foregroundStyle(headerSelected == tab ? .black : .gray04)
                        .onTapGesture {
                            headerSelected = tab
                        }
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    private var MovieButtons: some View {
        HStack(spacing: 23) {
            ForEach(movieTabs, id: \.self) { tab in
                let isOn = (buttonSelected == tab)
                
                Button {
                    buttonSelected = tab
                } label: {
                    Text(tab)
                        .font(.medium14)
                        .foregroundStyle(isOn ? .white : .gray04)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 6)
                        .frame(height: 38)
                        .foregroundStyle(.white)
                        .background {
                            RoundedRectangle(cornerRadius: 20)
                        }
                        .foregroundStyle(buttonSelected == tab ? .gray08 : .gray02)
                    
                }
                .glassEffect()
            }
            Spacer()
        }
    }
    private var MovieChart: some View {
        ScrollView(.horizontal, showsIndicators: false){
            LazyHStack(spacing: 24) {
                ForEach(movieModel.movies) { movie in
                    MovieCard(movie)
                }
            }
        }
    }
    private var MovieFeed: some View {
        VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("알고보면 더 재밌는 무비피드")
                            .font(.bold24)
                        Spacer()
                        
                        Button(action: {
                        }) {
                            Image(systemName: "arrow.right")
                                .foregroundStyle(.gray08)
                                .frame(width: 39, height: 39)
                                .glassEffect()
                        }
                    }
                    Image("feedMain")
                        .resizable()
                        .scaledToFit()
                    
                    VStack(alignment: .leading, spacing: 39) {
                        FeedRow(
                            image: "feed1",
                            title: "9월, 메가박스의 영화들(1) - 명작들의 재개봉",
                            subtitle: "<모노노케 히메>, <퍼펙트 블루>"
                        )
                        
                        FeedRow(
                            image: "feed2",
                            title: "메가박스 오리지널 티켓 Re.37 <얼굴>",
                            subtitle: "영화 속 앙극적인 감정의 대비"
                        )
                    }
                }
    }
    
    private func MovieCard(_ movie: MovieModel) -> some View {
        VStack(spacing: 8) {
            ZStack {
                Image(movie.movieImage).resizable().scaledToFill()
            }
            Button(action: {}) {
                Text("바로 예매")
                    .font(.medium16)
                    .foregroundStyle(.purple03)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 9)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.purple03))
                    }
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.movieName)
                    .font(.bold22)
                    .lineLimit(1)
                Text(movie.audienceText)
                    .font(.medium18)
            }
            .frame(width: 150, alignment: .leading)
        }
    }
    struct FeedRow: View {
        let image: String
        let title: String
        let subtitle: String
        
        var body: some View {
            HStack(alignment: .top) {
                Image(image)
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                VStack(alignment: .leading, spacing: 25) {
                    Text(title)
                        .font(.semiBold18)
                        .foregroundStyle(.black)
                    
                    Text(subtitle)
                        .font(.semiBold13)
                        .foregroundStyle(.gray03)
                }
            }
        }
    }

}

#Preview {
    HomeView()
}
