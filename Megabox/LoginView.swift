//
//  LoginView.swift
//  Megabox
//
//  Created by Jung Hyun Han on 9/18/25.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            Header
            Spacer()
            Textfield
            Spacer()
            LoginButton
            SignupButton
            SocialButton
            PosterSection
        }
        .padding(.horizontal, 16)
    }
    
    private var Header: some View {
        HStack {
            Text("로그인")
                .font(.semiBold24)
                .foregroundStyle(.black)
        }
    }
    private var Textfield: some View {
        VStack(spacing: 40) {
            VStack(spacing: 4) {
                TextField("아이디", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .font(.medium16)
                    .foregroundStyle(Color("gray03"))
                Divider()
                    .foregroundStyle(Color("gray02"))
            }
            VStack (spacing: 4) {
                TextField("비밀번호", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .font(.medium16)
                    .foregroundStyle(Color("gray03"))
                Divider()
                    .foregroundStyle(Color("gray02"))
            }
        }
    }
    private var LoginButton: some View {
        Button(action: {
            print("로그인 버튼 눌림")
        }){
            Text("로그인")
                .foregroundStyle(Color.white)
                .font(.bold18)
                .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 18)
        .background(Color.purple03)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    private var SignupButton: some View {
        Text("회원가입")
            .foregroundStyle(Color("gray04"))
            .font(.medium13)
            .padding(.top, 17)
            .padding(.bottom, 34)
    }
    private var SocialButton: some View {
        HStack(spacing: 40) {
            Image("naverLogin")
            Image("kakaoLogin")
            Image("appleLogin")
        }
        .padding(.bottom, 39)
    }
    private var PosterSection: some View {
        Image("umcPoster")
            .resizable()
            .scaledToFit()
    }
}

#Preview {
    LoginView()
}
