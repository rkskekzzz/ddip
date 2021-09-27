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
//            HStack {
////                Button(action: {}, label: {Image(systemName: "chevron.backward")})
////                Spacer()
////                Text("새로운 모임")
////                    .fontWeight(.bold)
////                Spacer()
////                Button(action: {}, label: {Text("완료")})
//            }
            Form {
                Section {
                    TextField("모임 제목을 입력하세요.", text: $meetingTitle)
                        .keyboardType(.default)
                    NavigationLink(destination: chooseLocationView()) { Text("위치를 입력하세요.") }
                    DatePicker("날짜, 시간 입력", selection: $date, in: Date()...)
                        .labelsHidden()
                }
                .padding()
            }
            .navigationTitle("새로운 모임")

        }
    }
}

struct NewMeetingView_Previews: PreviewProvider {
    static var previews: some View {
        NewMeetingView()
    }
}
