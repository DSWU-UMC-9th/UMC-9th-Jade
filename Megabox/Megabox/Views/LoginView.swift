//
//  LoginView.swift
//  Megabox
//
//  Created by Jung Hyun Han on 9/18/25.
//

import SwiftUI

struct LoginView: View {
    @State private var viewModel = LoginViewModel()
    
    @AppStorage("userId") private var userId: String = ""
    @AppStorage("userPwd") private var userPwd: String = ""

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
                TextField("아이디", text: $viewModel.loginModel.id)
                    .font(.medium16)
                    .foregroundStyle(.gray03)
                Divider()
                    .foregroundStyle(.gray02)
            }
            VStack (spacing: 4) {
                SecureField("비밀번호", text: $viewModel.loginModel.pwd)
                    .font(.medium16)
                    .foregroundStyle(.gray03)
                Divider()
                    .foregroundStyle(.gray02)
            }
        }
    }
    private var LoginButton: some View {
        Button(action: {
            userId = viewModel.loginModel.id
            userPwd = viewModel.loginModel.pwd
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
            .foregroundStyle(.gray04)
            .font(.medium13)
            .padding(.top, 17)
            .padding(.bottom, 34)
    }
    private var SocialButton: some View {
        HStack(spacing: 40) {
            Image(.naverLogin)
            Image(.kakaoLogin)
            Image(.appleLogin)
        }
        .padding(.bottom, 39)
    }
    private var PosterSection: some View {
        Image(.umcPoster)
            .resizable()
            .scaledToFit()
    }
}

#Preview() {
    LoginView()
}
