//
//  MeetingView.swift
//  ProjectDDIP
//
//  Created by Euimin Chung on 2021/09/24.
//

import SwiftUI
import SlideOverCard
import MapKit

/*
 * 아직 MapSearchView
 */

struct MeetingView: View {
    @Binding var slideCardState: SlideCardState
    
    let schedule: ScheduleModel = ScheduleModel.data[0]
    let date = Date()
    
    
    var body: some View {
        ZStack {
            VStack {
                VStack(spacing: 5) {
                    Button(action: {
                        slideCardState = .search
                    }) {
                        Text("Cancel")
                    }
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
                .frame(height: getSlideCardPositionValue(CardPosition.middle), alignment: .center)
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
//struct MeetingView_Previews: PreviewProvider {
//    static var previews: some View {
//        MeetingView()
//            .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
//            .previewDisplayName("iPhone SE")
//
//        MeetingView()
//            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
//            .previewDisplayName("iPhone 12 Pro Max")
//    }
//}
