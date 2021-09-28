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
    let schedule: ScheduleModel = ScheduleModel.data[0]


    var body: some View {
        let date = Date()

        return ZStack {
            MapView()
            SlideOverCard($meetingCardPosition, backgroundStyle: $meetingCardBackground) {
                VStack {
                    VStack(spacing: 5) {
                        Text("\(schedule.remainTime) 시간 후 시작")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        HStack(alignment: .bottom) {
                            Text(schedule.title)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Text("\(schedule.currentAttendees)/\(schedule.totalAttendees)")
                                .font(.caption)
                            Spacer()
                        }
                        Spacer()
                        HStack {
                            VStack {
                                Text(date, style: .date)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text(date, style: .time)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(.red)
                            }
                            Spacer()
                            Text("5,000")
                                .font(.title)
                            Text("원")
                        }
                        Spacer()
                        Button(action: { }, label: {
                            Text("등록하기")
                                .padding()
                                .frame(minWidth: 100, maxWidth: .infinity, alignment: .center)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(8)
                        })
                            .padding(30)
                        Spacer()
                    }
                    .padding(30)
                    .frame(height: UIScreen.main.bounds.height*(1 - 1/1.8), alignment: .center)
                    //CardPosition.middle 이 안 가져와져서 UIScreen.main.bounds.height/1.8 값으로 직접 넣어줌
                    VStack {
                        VStack(alignment: .leading, spacing: 10){
                            Label("\(schedule.position)", systemImage: "location.circle")
                            Label("2021. 7. 8", systemImage: "calendar.circle")
                                .foregroundColor(.red)
                            Label("\(schedule.startTime) - \(schedule.endTime)", systemImage: "clock.circle")
                            Label("\(schedule.currentAttendees)명", systemImage: "person.circle")
                        }
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
