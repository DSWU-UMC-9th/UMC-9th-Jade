//
//  MemberView.swift
//  Megabox
//
//  Created by Jung Hyun Han on 9/22/25.
//

import SwiftUI

struct MemberView: View {
    @AppStorage("userName") private var userName: String = ""
    var body: some View {
        VStack {
            Spacer().frame(height: 103)
            ProfileHeader
            Spacer().frame(height: 15)
            ClubMembership
            Spacer().frame(height: 33)
            StatusInformation
            Spacer().frame(height: 33)
            ReservationList()
            Spacer()
        }
        .padding(.horizontal, 16)
    }
    
    private var ProfileHeader: some View {
        VStack {
            HStack {
                HStack {
                    Text("\(userName)님")
                        .font(.semiBold24)
                        .foregroundStyle(.black)
                    
                    Text("WELCOME")
                        .font(.medium14)
                        .foregroundStyle(.white)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color("tag"))
                        }
                }
                
                Spacer()
                
                Button {
                } label: {
                    Text("회원정보")
                        .font(.semiBold14)
                        .foregroundStyle(.white)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background{
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color("gray07"))
                        }
                }
            }
            
            HStack {
                Text("멤버십 포인트")
                    .font(.semiBold14)
                    .foregroundStyle(Color("gray04"))
                
                Text("500P")
                    .font(.medium14)
                    .foregroundStyle(.black)
                
                Spacer()
            }
        }
    }
    private var ClubMembership: some View {
        Button {
        } label: {
            HStack {
                Text("클럽 멤버십")
                    .font(.semiBold16)
                Image(systemName: "chevron.right")
                Spacer()
            }
            .foregroundStyle(.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 8)
            .background(
                LinearGradient(colors: [Color("LinearGradient01"), Color("LinearGradient02"), Color("LinearGradient03")
                ],
                startPoint: .leading,
                endPoint: .trailing)
            )
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
    private var StatusInformation: some View {
        HStack(spacing: 0) {
            StatusItem(title: "쿠폰", value: "2")
            
            Divider()
                .padding(.horizontal, 43)
            
            StatusItem(title: "스토어 교환권", value: "0")
            
            Divider()
                .padding(.horizontal, 43)
            
            StatusItem(title: "모바일 티켓", value: "0")
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .background{
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color("gray02"), lineWidth: 1)
        }
        .frame(maxWidth: .infinity, maxHeight: 76)
    }
    private struct StatusItem: View {
        let title: String
        let value: String
        
        var body: some View {
            VStack(spacing: 8) {
                Text(title)
                    .font(.semiBold12)
                    .foregroundStyle(Color("gray02"))
                    .fixedSize()
                
                Text(value)
                    .font(.semiBold18)
                    .foregroundStyle(.black)
                    .fixedSize()
            }
            .frame(maxWidth: .infinity)
        }
    }
    private struct ReservationList: View {
        var body: some View {
            HStack {
                ReservationButton(image: "infoIcon1", text: "영화별예매")
                
                Spacer()
                
                ReservationButton(image: "infoIcon2", text: "극장별예매")
                
                Spacer()
                
                ReservationButton(image: "infoIcon3", text: "특별관예매")
                
                Spacer()
                
                ReservationButton(image: "infoIcon4", text: "모바일오더")
            }
        }
    }
    private struct ReservationButton: View {
        let image: String
        let text: String
        
        var body: some View {
            Button {} label: {
                VStack {
                    Image(image)
                        .resizable()
                        .frame(width: 36, height: 36)
                    
                    Text(text)
                        .font(.medium16)
                        .foregroundStyle(.black)
                        .fixedSize()
                }

            }
        }
    }
}

#Preview {
    MemberView()
}
