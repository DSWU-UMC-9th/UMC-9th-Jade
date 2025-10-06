//
//  TabView.swift
//  Megabox
//
//  Created by Jung Hyun Han on 10/1/25.
//

import SwiftUI

struct MainTabView: View {
    let viewModel: LoginViewModel
    
    var body: some View {
        TabView {
            Tab("홈", image: "tab1") {
                HomeView()
            }
            
            Tab("바로 예매", image: "tab2") {
                //ReservationView()
            }
            
            Tab("모바일 오더", image: "tab3") {
                //OrderView()
            }
            
            Tab("마이 페이지", image: "tab4") {
                MemberView(viewModel: viewModel)
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    MainTabView(viewModel: LoginViewModel())
}

