//
//  ScheduleView.swift
//  ProjectDDIP
//
//  Created by su on 2021/09/18.
//

import SwiftUI

struct ScheduleView: View {
    @Binding var showingScheduleView: Bool
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
            .navigationBarItems(leading: Button(action: { showingScheduleView = false }, label: {
                Text("back")
            }), trailing: Button(action: { }, label: {
                Text("edit")
            }))
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView(showingScheduleView: .constant(true), schedules: Schedule.data)
    }
}
