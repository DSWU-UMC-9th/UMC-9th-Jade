//
//  MemberInfoView.swift
//  Megabox
//
//  Created by Jung Hyun Han on 9/23/25.
//

import SwiftUI

struct MemberInfoView: View {
    @AppStorage("userId") private var userId: String = ""
    @AppStorage("userName") private var userName: String = ""
    
    @State private var editName: String = ""
    
    var body: some View {
        VStack {
            Header
            Spacer().frame(height: 52)
            BasicInfoText
            Spacer().frame(height: 26)
            BasicInfoTextField
            Spacer()
        }
        .padding(.horizontal, 16)
        .onAppear {
            editName = userName
        }
    }
    
    var Header: some View {
        ZStack {
            Text("회원정보 관리")
                .font(.medium16)
                .foregroundStyle(.black)
        }
    }
    var BasicInfoText: some View {
        Group {
            Text("기본 정보")
                .font(.bold18)
                .foregroundStyle(.black)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    var BasicInfoTextField: some View {
        VStack(spacing:24) {
            VStack (alignment: .leading, spacing: 4) {
                Text(userId)
                    .font(.medium18)
                    .foregroundStyle(.black)
                Divider()
                    .foregroundStyle(.gray02)
            }
            
            VStack (alignment: .leading, spacing: 4) {
                HStack {
                    TextField(userName, text: $editName)
                        .font(.medium18)
                        .foregroundStyle(.black)
                    
                    Spacer()
                    
                    Button {
                        userName = editName
                    }
                    label: {
                        Text("변경")
                            .font(.medium10)
                            .foregroundStyle(.gray03)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.gray03, lineWidth: 1)
                            }
                    }
                }
                Divider()
                    .foregroundStyle(.gray02)
                
            }
        }
    }
}

#Preview {
    MemberInfoView()
}
