//
//  SplashView.swift
//  Megabox
//
//  Created by Jung Hyun Han on 9/18/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack (alignment: .center){
            Color("white")
                .ignoresSafeArea()
            
            Image("logo")
        }
    }
}

#Preview {
    SplashView()
}
