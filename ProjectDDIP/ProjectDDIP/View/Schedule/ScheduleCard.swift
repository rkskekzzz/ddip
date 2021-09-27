//
//  ScheduleView.swift
//  ProjectDDIP
//
//  Created by su on 2021/09/18.
//

import SwiftUI
import SlideOverCard

struct ScheduleCard: View {
    @Binding var activateDeleteButton: Bool

    let schedule: ScheduleModel
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
//
//extension CardPosition {
//    case TEST_CORE_DATA
//
//    func offsetFromTop() -> CGFloat {
//
//    }
//}


struct ScheduleCard_Previews: PreviewProvider {
//    static var schedule = MySchedule

    static var previews: some View {
        ScheduleCard(activateDeleteButton: .constant(false), schedule: ScheduleModel.data[0], deleteScheldule: {id in print(id)})
    }
}
