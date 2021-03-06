//
//  ButtonVIew.swift
//  ProjectDDIP
//
//  Created by 차영훈 on 2021/09/28.
//

import SwiftUI

struct ButtonView: View {
    @Binding var slideCardState: SlideCardState
    @State var showSheet: Bool = false
    
    var body: some View {
        HStack {
            Button(action: {
                Network.share.postButtonTest()
            }) {
                Image(systemName: "minus.circle")
                    .font(.system(size: 50))
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(100)
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
            }
            Button(action: {
                slideCardState = .meeting
            }) {
                Image(systemName: "plus.circle")
                    .font(.system(size: 50))
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(100)
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
            }
            Button(action: {
//                slideCardState = .schedule
                showSheet = true
            }) {
                Image(systemName: "calendar.circle")
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                        .background(Color.pink)
                        .cornerRadius(100)
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
            }
//            .fullScreenCover(isPresented: $showSheet, content: {
//                ScheduleView(slideCardState: $slideCardState, mySchedule: EnvironmentObject<MySchedule>())
//            })
            .sheet(isPresented: $showSheet, content: {
                ScheduleView(slideCardState: $slideCardState, mySchedule: EnvironmentObject<MySchedule>())
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        .padding(.vertical, 100)
        .padding(.horizontal, 40)
    }
}
