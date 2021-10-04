//
//  NewMeetingView.swift
//  ProjectDDIP
//
//  Created by Euimin Chung on 2021/09/28.
//

import SwiftUI
//Floating

struct chooseLocationView: View {
    var body: some View {
        NavigationView {
            Text("위치 선택")
        }
    }
}

struct NewMeetingView: View {
    @State private var meetingTitle = ""
    @State private var date = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("모임 제목을 입력하세요.", text: $meetingTitle)
                        .keyboardType(.default)
                    NavigationLink(destination: chooseLocationView()) { Text("위치를 입력하세요.") }
                    DatePicker("날짜, 시간 입력", selection: $date, in: Date()...)
                        .labelsHidden()
                    //여기의 date 변수를 MeetingView에서도 받아서 쓰고 싶은데 아직 구현 못함
                }
                .navigationBarHidden(true)
                .padding()
            }
            
        }
        .navigationTitle("모임 만들기")
        .navigationBarBackButtonHidden(false)
    }
}

//struct NewMeetingView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewMeetingView()
//    }
//}
