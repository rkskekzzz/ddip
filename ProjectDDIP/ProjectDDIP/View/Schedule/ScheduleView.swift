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
            LazyVStack {
                ForEach(schedules, id: \.id) { schedule in
                    ScheduleCard(schedule: schedule)
                }.background(RoundedRectangle(cornerRadius: 20).fill(Color.white).shadow(radius: 4))
                .padding(.vertical, 5)
            }
            .navigationTitle("Schedule")
            .padding(.horizontal, 20)
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView(schedules: Schedule.data)
    }
}
