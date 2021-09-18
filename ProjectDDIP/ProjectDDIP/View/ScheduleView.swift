//
//  ScheduleView.swift
//  ProjectDDIP
//
//  Created by su on 2021/09/18.
//

import SwiftUI

struct ScheduleView: View {
    let schedules: [Schedule]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(schedules, id: \.id) { schedule in
                    ScheduleCard(schedule: schedule)
                        .border(Color.blue, width: 2)
                        .cornerRadius(10)
                        .background(Color.white)
                        // shadow 어떻게 씀? to 의민
                }
            }
            .navigationTitle("Schedule")
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView(schedules: Schedule.data)
    }
}
