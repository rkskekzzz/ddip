//
//  MeetingView.swift
//  ProjectDDIP
//
//  Created by Euimin Chung on 2021/09/24.
//

import SwiftUI
import SlideOverCard

struct MeetingView: View {
    @State private var meetingCardPosition = CardPosition.middle
    @State private var meetingCardBackground = BackgroundStyle.solid
    
    
    var body: some View {
        ZStack {
            MapView()
            SlideOverCard($meetingCardPosition, backgroundStyle: $meetingCardBackground) {
                VStack {
                    Text("6시간 후 시작")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    HStack {
                        Text("면접 스터디 모임")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        VStack {
                            Text("")
                            Text("9/10")
                        }
                        Spacer(minLength: 70)
                    }
                    HStack {
                        VStack {
                            Text("2021. 7. 8")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("8:00AM - 10:00AM")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.red)
                        }
                        Spacer()
                        Text("5,000")
                            .font(.title)
                        Text("원")
                    }
                    .padding()
                    Button(action: { }, label: {
                      Text("등록하기")
                        .padding()
                        .frame(minWidth: 100, maxWidth: .infinity, alignment: .center)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                    })
                        .padding(30)
                    VStack(alignment: .leading, spacing: 10){
                        Label("서울 종로구 창경궁로", systemImage: "location.circle")
                        Label("2021. 7. 8", systemImage: "calendar.circle")
                        Label("8:00AM - 10:00AM", systemImage: "clock.circle")
                        Label("9명", systemImage: "person.circle")
                    }
                }
            }
        }

    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView()
            .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
            .previewDisplayName("iPhone SE")

        MeetingView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
            .previewDisplayName("iPhone 12 Pro Max")
    }
}
