//
//  ScheduleView.swift
//  ProjectDDIP
//
//  Created by su on 2021/09/18.
//

import SwiftUI

struct Schedule: Identifiable {
    let id: UUID
    var title: String
    var remainTime: Int
    
    var totalAttendees: Int
    var currentAttendees: Int
    
    var position: String
    
    var startTime: Int
    var endTime: Int
    
    init(id: UUID = UUID(), title: String, remainTime: Int, totalAttendees: Int, currentAttendees: Int, position: String, startTime: Int, endTime: Int) {
        self.id = id
        self.title = title
        self.remainTime = remainTime
        self.totalAttendees = totalAttendees
        self.currentAttendees = currentAttendees
        self.position = position
        self.startTime = startTime
        self.endTime = endTime
    }
   
    
}

extension Schedule {
    static var data: [Schedule] {
        [
            Schedule(title: "면접 스터디", remainTime: 3,totalAttendees: 10, currentAttendees: 9, position: "사보이시티 잠실",startTime: 8, endTime: 24),
            Schedule(title: "모여서 각자 코딩", remainTime: 3,totalAttendees: 10, currentAttendees: 9, position: "사보이시티 잠실",startTime: 8, endTime: 24),
            Schedule(title: "커피마시기 모임", remainTime: 3,totalAttendees: 10, currentAttendees: 9, position: "사보이시티 잠실",startTime: 8, endTime: 24),
            Schedule(title: "책읽고 독후감쓰기", remainTime: 3,totalAttendees: 10, currentAttendees: 9, position: "사보이시티 잠실",startTime: 8, endTime: 24)
        ]
    }
}

struct ScheduleCard: View {
    @Binding var activateDeleteButton: Bool

    let schedule: Schedule
    var deleteScheldule : (UUID) -> ()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(schedule.remainTime) 시간 후 시작")
                .font(.caption2)
            HStack(alignment: .bottom) {
                Text(schedule.title)
                    .font(.title)
                Text("\(schedule.currentAttendees)/\(schedule.totalAttendees)")
                    .font(.caption2)
                    .foregroundColor(.primary)
                Spacer()
                if activateDeleteButton {
                    Button(action: { deleteScheldule(schedule.id) }, label: { Image(systemName: "minus.circle") })
                        .font(.title2)  //size of minus.circle button
                        .foregroundColor(.red)
                }
                
            }
            Spacer()
            VStack(alignment: .leading) {
                Label("\(schedule.position)", systemImage: "location.circle")
                Label("\(schedule.currentAttendees) 명", systemImage: "person.circle")
            }
            .font(.subheadline)
        }
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: 100,
              alignment: .topLeading
            )
        .padding(30)
    }
}



//struct ScheduleCard_Previews: PreviewProvider {
//    static var schedule = Schedule.data[0]
//
//    static var previews: some View {
//        ScheduleCard(activateDeleteButton: <#T##Binding<Bool>#>, schedule: <#T##Schedule#>, deleteScheldule: <#T##(UUID) -> ()#>)
//    }
//}
